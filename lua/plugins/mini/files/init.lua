---@type LazySpec
return {
  'nvim-mini/mini.files',
  enabled = true,
  cond = not vim.g.vscode,
  version = false,
  keys = {
    {
      '<leader>fe',
      function() require('mini.files').open(vim.api.nvim_buf_get_name(0), true) end,
      desc = 'File Explorer (mini)',
    },
  },
  opts = {
    mappings = {
      close = 'q',
      go_in = '',
      go_in_plus = '<cr>',
      go_out = '',
      go_out_plus = '-',
      mark_goto = "'",
      mark_set = 'm',
      reset = '<BS>',
      reveal_cwd = '@',
      show_help = 'g?',
      synchronize = 's',
      trim_left = '<',
      trim_right = '>',
    },
    options = {
      use_as_default_explorer = false,
    },
    windows = {
      preview = true,
      width_preview = math.min(math.floor(vim.o.columns * 0.33), 80),
    },
  },
  config = function(_, opts)
    require('mini.files').setup(opts)

    local show_dotfiles = true

    ---@diagnostic disable-next-line: unused-local
    local filter_show = function(fs_entry) return true end

    local filter_hide = function(fs_entry) return not vim.startswith(fs_entry.name, '.') end

    local toggle_dotfiles = function()
      show_dotfiles = not show_dotfiles
      local new_filter = show_dotfiles and filter_show or filter_hide
      MiniFiles.refresh { content = { filter = new_filter } }
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id

        vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
        vim.keymap.set('n', '<esc>', function() require('mini.files').close() end, { buffer = buf_id })
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesActionRename',
      callback = function(event) Snacks.rename.on_rename_file(event.data.from, event.data.to) end,
    })

    local nsMiniFiles = vim.api.nvim_create_namespace 'mini_files_git'
    local autocmd = vim.api.nvim_create_autocmd
    local _, MiniFiles = pcall(require, 'mini.files')

    -- Cache for git status
    local gitStatusCache = {}
    local cacheTimeout = 2000 -- in milliseconds
    local uv = vim.uv or vim.loop

    local function isSymlink(path)
      local stat = uv.fs_lstat(path)
      return stat and stat.type == 'link'
    end

    ---@type table<string, {symbol: string, hlGroup: string}>
    ---@param status string
    ---@return string symbol, string hlGroup
    local function mapSymbols(status, is_symlink)
      local statusMap = {
        [' M'] = { symbol = '•', hlGroup = 'GitSignsChange' }, -- Modified in the working directory
        ['M '] = { symbol = '✹', hlGroup = 'GitSignsChange' }, -- modified in index
        ['MM'] = { symbol = '≠', hlGroup = 'GitSignsChange' }, -- modified in both working tree and index
        ['A '] = { symbol = '+', hlGroup = 'GitSignsAdd' }, -- Added to the staging area, new file
        ['AA'] = { symbol = '≈', hlGroup = 'GitSignsAdd' }, -- file is added in both working tree and index
        ['D '] = { symbol = '-', hlGroup = 'GitSignsDelete' }, -- Deleted from the staging area
        [' D'] = { symbol = '-', hlGroup = 'GitSignsDelete' }, -- Deleted from index
        ['DU'] = { symbol = '󰦍', hlGroup = 'GitSignsDelete' }, -- Deleted from index and unmerged in working tree
        ['AM'] = { symbol = '⊕', hlGroup = 'GitSignsChange' }, -- added in working tree, modified in index
        ['AD'] = { symbol = '-•', hlGroup = 'GitSignsChange' }, -- Added in the index and deleted in the working directory
        ['R '] = { symbol = '→', hlGroup = 'GitSignsChange' }, -- Renamed in the index
        ['U '] = { symbol = '‖', hlGroup = 'GitSignsChange' }, -- Unmerged path
        ['UU'] = { symbol = '⇄', hlGroup = 'GitSignsAdd' }, -- file is unmerged
        ['UA'] = { symbol = '⊕', hlGroup = 'GitSignsAdd' }, -- file is unmerged and added in working tree
        ['??'] = { symbol = '', hlGroup = 'GitSignsAdd' }, -- Untracked files
        ['!!'] = { symbol = '', hlGroup = 'Comment' }, -- Ignored files
      }

      local result = statusMap[status] or { symbol = '?', hlGroup = 'NonText' }
      local gitSymbol = result.symbol
      local gitHlGroup = result.hlGroup

      local symlinkSymbol = is_symlink and '↩' or ''

      -- Combine symlink symbol with Git status if both exist
      local combinedSymbol = (symlinkSymbol .. gitSymbol):gsub('^%s+', ''):gsub('%s+$', '')
      -- Change the color of the symlink icon from "GitSignsDelete" to something else
      local combinedHlGroup = is_symlink and 'GitSignsDelete' or gitHlGroup

      return combinedSymbol, combinedHlGroup
    end

    ---@param cwd string
    ---@param callback function
    ---@return nil
    local function fetchGitStatus(cwd, callback)
      local clean_cwd = cwd:gsub('^minifiles://%d+/', '')
      ---@param content table
      local function on_exit(content)
        if content.code == 0 then
          callback(content.stdout) -- vim.g.content = content.stdout
        end
      end
      ---@see vim.system
      vim.system({ 'git', 'status', '--ignored', '--porcelain' }, { text = true, cwd = clean_cwd }, on_exit)
    end

    ---@param buf_id integer
    ---@param gitStatusMap table
    ---@return nil
    local function updateMiniWithGit(buf_id, gitStatusMap)
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(buf_id) then
          local nlines = vim.api.nvim_buf_line_count(buf_id)
          local cwd = vim.fs.root(buf_id, '.git')
          local escapedcwd = cwd and vim.pesc(cwd)
          escapedcwd = vim.fs.normalize(escapedcwd)

          for i = 1, nlines do
            local entry = MiniFiles.get_fs_entry(buf_id, i)
            if not entry then break end
            local relativePath = entry.path:gsub('^' .. escapedcwd .. '/', '')
            local status = gitStatusMap[relativePath]

            if status then
              local symbol, hlGroup = mapSymbols(status, isSymlink(entry.path))
              vim.api.nvim_buf_set_extmark(buf_id, nsMiniFiles, i - 1, 0, {
                sign_text = symbol,
                sign_hl_group = hlGroup,
                priority = 2,
              })
              -- This below code is responsible for coloring the text of the items. comment it out if you don't want that
              local line = vim.api.nvim_buf_get_lines(buf_id, i - 1, i, false)[1]
              -- Find the name position accounting for potential icons
              local nameStartCol = line:find(vim.pesc(entry.name)) or 0

              if nameStartCol > 0 then
                vim.api.nvim_buf_set_extmark(buf_id, nsMiniFiles, i - 1, nameStartCol - 1, {
                  end_col = nameStartCol + #entry.name - 1,
                  hl_group = hlGroup,
                })
              end
            else
            end
          end
        end
      end)
    end

    -- Thanks for the idea of gettings https://github.com/refractalize/oil-git-status.nvim signs for dirs
    ---@param content string
    ---@return table
    local function parseGitStatus(content)
      local gitStatusMap = {}
      -- lua match is faster than vim.split (in my experience )
      for line in content:gmatch '[^\r\n]+' do
        local status, filePath = string.match(line, '^(..)%s+(.*)')
        -- Split the file path into parts
        local parts = {}
        for part in filePath:gmatch '[^/]+' do
          table.insert(parts, part)
        end
        -- Start with the root directory
        local currentKey = ''
        for i, part in ipairs(parts) do
          if i > 1 then
            -- Concatenate parts with a separator to create a unique key
            currentKey = currentKey .. '/' .. part
          else
            currentKey = part
          end
          -- If it's the last part, it's a file, so add it with its status
          if i == #parts then
            gitStatusMap[currentKey] = status
          else
            -- If it's not the last part, it's a directory. Check if it exists, if not, add it.
            if not gitStatusMap[currentKey] then gitStatusMap[currentKey] = status end
          end
        end
      end
      return gitStatusMap
    end

    ---@param buf_id integer
    ---@return nil
    local function updateGitStatus(buf_id)
      if not vim.fs.root(buf_id, '.git') then return end
      local cwd = vim.fs.root(buf_id, '.git')
      -- local cwd = vim.fn.expand("%:p:h")
      local currentTime = os.time()

      if gitStatusCache[cwd] and currentTime - gitStatusCache[cwd].time < cacheTimeout then
        updateMiniWithGit(buf_id, gitStatusCache[cwd].statusMap)
      else
        fetchGitStatus(cwd, function(content)
          local gitStatusMap = parseGitStatus(content)
          gitStatusCache[cwd] = {
            time = currentTime,
            statusMap = gitStatusMap,
          }
          updateMiniWithGit(buf_id, gitStatusMap)
        end)
      end
    end

    ---@return nil
    local function clearCache() gitStatusCache = {} end

    local function augroup(name) return vim.api.nvim_create_augroup('MiniFiles_' .. name, { clear = true }) end

    autocmd('User', {
      group = augroup 'start',
      pattern = 'MiniFilesExplorerOpen',
      callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        updateGitStatus(bufnr)
      end,
    })

    autocmd('User', {
      group = augroup 'close',
      pattern = 'MiniFilesExplorerClose',
      callback = function() clearCache() end,
    })

    autocmd('User', {
      group = augroup 'update',
      pattern = 'MiniFilesBufferUpdate',
      callback = function(args)
        local bufnr = args.data.buf_id
        local cwd = vim.fs.root(bufnr, '.git')
        if gitStatusCache[cwd] then updateMiniWithGit(bufnr, gitStatusCache[cwd].statusMap) end
      end,
    })

    local map_split = function(buf_id, lhs, direction)
      local rhs = function()
        local new_target_window
        local cur_target_window = require('mini.files').get_explorer_state().target_window
        if cur_target_window ~= nil then
          vim.api.nvim_win_call(cur_target_window, function()
            vim.cmd('belowright ' .. direction .. ' split')
            new_target_window = vim.api.nvim_get_current_win()
          end)

          require('mini.files').set_target_window(new_target_window)
          require('mini.files').go_in { close_on_file = true }
        end
      end

      local desc = 'Open in ' .. direction .. ' split'
      vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak keys to your liking
        map_split(buf_id, '<C-s>', 'belowright horizontal')
        map_split(buf_id, '<C-v>', 'belowright vertical')
        map_split(buf_id, '<C-t>', 'tab')
      end,
    })

    -- Set focused directory as current working directory
    local set_cwd = function()
      local path = (MiniFiles.get_fs_entry() or {}).path
      if path == nil then return vim.notify 'Cursor is not on valid entry' end
      vim.fn.chdir(vim.fs.dirname(path))
    end

    -- Yank in register full path of entry under cursor
    local yank_path = function()
      local path = (MiniFiles.get_fs_entry() or {}).path
      if path == nil then return vim.notify 'Cursor is not on valid entry' end
      vim.fn.setreg(vim.v.register, path)
    end

    -- Open path with system default handler (useful for non-text files)
    local ui_open = function() vim.ui.open(MiniFiles.get_fs_entry().path) end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local b = args.data.buf_id
        vim.keymap.set('n', 'g~', set_cwd, { buffer = b, desc = 'Set cwd' })
        vim.keymap.set('n', 'gX', ui_open, { buffer = b, desc = 'OS open' })
        vim.keymap.set('n', 'gy', yank_path, { buffer = b, desc = 'Yank path' })
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id

        require('plugins.mini.files.scaffold').gen_scaffold_keymaps(buf_id)
      end,
    })
  end,
}
