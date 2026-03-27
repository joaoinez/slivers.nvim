local map = Slivers.keymaps.safe_keymap_set

map('n', '<leader>qpd', function()
  local root = Snacks.git.get_root()
  if not root then
    vim.notify('Could not determine project root', vim.log.levels.ERROR)
    return
  end

  -- /clp:NoSummary avoids the error block being printed a second time at the end
  -- --tl:off disables the terminal logger so we get classic MSBuild plain-text output
  local cmd = vim.g.q_cs_build_cmd or { 'dotnet', 'build', '--nologo', '--tl:off', '/clp:NoSummary' }

  vim.notify('Running ' .. table.concat(cmd, ' '), vim.log.levels.INFO)

  vim.system(cmd, { cwd = root, text = true }, function(result)
    local qfitems = {}

    -- Classic MSBuild diagnostic format:
    -- /abs/path/File.cs(line,col): error CS0001: message [/abs/path/Project.csproj]
    -- /abs/path/File.cs(line,col): warning CS0168: message [/abs/path/Project.csproj]
    -- The [project] suffix is optional (absent when terminal logger is active)
    local error_pattern = '^%s*(.-)%((%d+),(%d+)%)%s*:%s*error%s+(.-)%s*%[.-%]%s*$'
    local warn_pattern = '^%s*(.-)%((%d+),(%d+)%)%s*:%s*warning%s+(.-)%s*%[.-%]%s*$'
    local error_pattern_no_proj = '^%s*(.-)%((%d+),(%d+)%)%s*:%s*error%s+(.-)%s*$'
    local warn_pattern_no_proj = '^%s*(.-)%((%d+),(%d+)%)%s*:%s*warning%s+(.-)%s*$'

    local seen = {}
    local output = (result.stdout or '') .. (result.stderr or '')
    for line in output:gmatch '[^\n]+' do
      local filename, lnum, col, text = line:match(error_pattern)
      local qftype = 'E'

      if not filename then
        filename, lnum, col, text = line:match(warn_pattern)
        qftype = 'W'
      end

      if not filename then
        filename, lnum, col, text = line:match(error_pattern_no_proj)
        qftype = 'E'
      end

      if not filename then
        filename, lnum, col, text = line:match(warn_pattern_no_proj)
        qftype = 'W'
      end

      if filename then
        local key = filename .. ':' .. lnum .. ':' .. col
        if not seen[key] then
          seen[key] = true
          table.insert(qfitems, {
            filename = filename,
            lnum = tonumber(lnum),
            col = tonumber(col),
            text = text,
            type = qftype,
          })
        end
      end
    end

    vim.schedule(function()
      if #qfitems == 0 then
        vim.notify('dotnet build: no errors found', vim.log.levels.INFO)
        return
      end

      vim.fn.setqflist({}, 'r', { title = 'dotnet build', items = qfitems })
      require('trouble').open 'qflist'
    end)
  end)
end, { desc = 'dotnet' })
