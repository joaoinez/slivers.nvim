local M = {}

-- NOTE: See https://github.com/Cliffback/netcoredbg-macOS-arm64.nvim/blob/main/lua/netcoredbg-macOS-arm64/init.lua
-- NOTE: See https://git.ramboe.io/YouTube/neovim-c-improving-the-debugging-experience

---@param dap table
function M.dap_adapters(dap)
  -- HACK: netcoredbg from mason doesn't support macOS ARM64 natively yet.
  -- Keep an eye on https://github.com/Samsung/netcoredbg for updates.
  local netcoredbg_path = vim.fn.has 'mac' == 1
      and Slivers.lazy.get_plugin('netcoredbg-macOS-arm64.nvim').dir .. '/netcoredbg/netcoredbg'
    or Slivers.mason.get_pkg_path('netcoredbg', 'netcoredbg')

  dap.adapters['coreclr'] = {
    type = 'executable',
    command = netcoredbg_path,
    args = { '--interpreter=vscode' },
  }

  dap.adapters['netcoredbg'] = {
    type = 'executable',
    command = netcoredbg_path,
    args = { '--interpreter=vscode' },
  }
end

M.dap_filetypes = { 'cs' }

---@param dap table
function M.dap_configurations(dap)
  --- Finds the .csproj file in the project root
  ---@return string|nil csproj_path Path to the .csproj file
  ---@return string|nil project_name Name of the project (without .csproj extension)
  local function find_csproj()
    -- Start from current buffer's directory
    local current_file = vim.fn.expand '%:p'
    local current_dir = vim.fn.fnamemodify(current_file, ':h')

    -- Find .csproj file by walking up the directory tree
    local csproj_files = vim.fs.find(function(name) return name:match '%.csproj$' end, {
      path = current_dir,
      upward = true,
      type = 'file',
    })

    if #csproj_files == 0 then
      vim.notify('No .csproj file found in project', vim.log.levels.ERROR)
      return nil, nil
    end

    local csproj_path = csproj_files[1]
    local project_name = vim.fn.fnamemodify(csproj_path, ':t:r')
    return csproj_path, project_name
  end

  --- Finds all .NET target framework directories in bin/Debug
  ---@param csproj_dir string Directory containing the .csproj file
  ---@return table<string> List of framework directories (e.g., {"net8.0", "net6.0"})
  local function find_target_frameworks(csproj_dir)
    local debug_dir = csproj_dir .. '/bin/Debug'

    -- Check if Debug directory exists
    if vim.fn.isdirectory(debug_dir) == 0 then return {} end

    -- Find all directories matching .NET framework patterns
    local frameworks = {}
    local entries = vim.fn.readdir(debug_dir)

    for _, entry in ipairs(entries) do
      local full_path = debug_dir .. '/' .. entry
      -- Match patterns like net6.0, net7.0, net8.0, netcoreapp3.1, etc.
      if vim.fn.isdirectory(full_path) == 1 and entry:match '^net' then table.insert(frameworks, entry) end
    end

    return frameworks
  end

  --- Builds the path to the DLL for the C# debugger
  ---@return string|nil dll_path Path to the DLL to debug
  local function build_dll_path()
    local csproj_path, project_name = find_csproj()
    if not csproj_path or not project_name then return nil end

    local csproj_dir = vim.fn.fnamemodify(csproj_path, ':h')

    -- NOTE: See https://codeberg.org/mfussenegger/nvim-dap/wiki/Cookbook#making-debugging-net-easier
    local cmd = 'dotnet build -c Debug ' .. csproj_dir .. ' > /dev/null'
    local f = os.execute(cmd)
    if f == 0 then
      vim.notify '\nBuild: ✅ '
    else
      vim.notify('\nBuild: ❌ (code: ' .. f .. ')')
    end

    local frameworks = find_target_frameworks(csproj_dir)

    if #frameworks == 0 then
      vim.notify('No target frameworks found in bin/Debug. Build the project first.', vim.log.levels.ERROR)
      return nil
    end

    -- If only one framework, use it directly
    if #frameworks == 1 then
      local dll_path = string.format('%s/bin/Debug/%s/%s.dll', csproj_dir, frameworks[1], project_name)
      return dll_path
    end

    -- Multiple frameworks found, show picker
    local selected_framework = nil
    local co = coroutine.running()

    Snacks.picker {
      finder = function()
        return vim.tbl_map(
          function(framework)
            return {
              text = framework,
              value = string.format('%s/bin/Debug/%s/%s.dll', csproj_dir, framework, project_name),
            }
          end,
          frameworks
        )
      end,
      format = 'text',
      title = 'Select Target Framework',
      layout = { preset = 'select' },
      confirm = function(picker, item)
        picker:close()
        if item then selected_framework = item.value end
        if co then coroutine.resume(co) end
      end,
    }

    -- Wait for user selection
    if co then coroutine.yield() end

    return selected_framework
  end

  --- Parses a .env file and returns a table of environment variables
  ---@param env_path string Path to the .env file
  ---@return table<string, string> env_vars Environment variables from the file
  local function parse_env_file(env_path)
    local env_vars = {}

    -- Check if file exists
    if vim.fn.filereadable(env_path) == 0 then return env_vars end

    local lines = vim.fn.readfile(env_path)

    for _, line in ipairs(lines) do
      -- Skip comments and empty lines
      if not line:match '^%s*#' and not line:match '^%s*$' then
        -- Match KEY=VALUE pattern
        local key, value = line:match '^%s*([%w_]+)%s*=%s*(.*)%s*$'
        if key and value then
          -- Remove surrounding quotes if present
          value = value:gsub('^["\']', ''):gsub('["\']$', '')
          env_vars[key] = value
        end
      end
    end

    return env_vars
  end

  --- Loads environment variables from .env file in project root
  ---@return table<string, string> env_vars Environment variables for the debugger
  local function load_env_vars()
    local csproj_path = find_csproj()
    if not csproj_path then return { ASPNETCORE_ENVIRONMENT = 'Development' } end

    local csproj_dir = vim.fn.fnamemodify(csproj_path, ':h')
    local env_path = csproj_dir .. '/.env'

    local env_vars = parse_env_file(env_path)

    -- Set default ASPNETCORE_ENVIRONMENT if not present
    if not env_vars.ASPNETCORE_ENVIRONMENT then env_vars.ASPNETCORE_ENVIRONMENT = 'Development' end

    return env_vars
  end

  local env_vars = load_env_vars()

  for _, language in ipairs(M.dap_filetypes) do
    dap.configurations[language] = {
      {
        type = 'coreclr',
        name = 'Launch .NET Core DLL',
        request = 'launch',
        program = build_dll_path,
        cwd = '${fileDirname}',
        env = env_vars,
      },
      {
        type = 'coreclr',
        name = 'Attach to process',
        request = 'attach',
        pid = require('dap.utils').pick_process,
        args = {},
      },
    }
  end
end

return M
