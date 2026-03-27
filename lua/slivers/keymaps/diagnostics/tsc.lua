local map = Slivers.keymaps.safe_keymap_set

map('n', '<leader>qpt', function()
  local root = Snacks.git.get_root()
  if not root then
    vim.notify('Could not determine project root', vim.log.levels.ERROR)
    return
  end

  local cmd = vim.g.q_ts_typecheck_cmd or { 'npx', 'tsc', '--noEmit' }

  vim.notify('Running ' .. table.concat(cmd, ' '), vim.log.levels.INFO)

  vim.system(cmd, { cwd = root, text = true }, function(result)
    local qfitems = {}

    local error_pattern = '^(.-)%((%d+),(%d+)%)%s*:%s*error%s+(.-)%s*$'
    local warn_pattern = '^(.-)%((%d+),(%d+)%)%s*:%s*warning%s+(.-)%s*$'

    local output = (result.stdout or '') .. (result.stderr or '')
    for line in output:gmatch '[^\n]+' do
      local filename, lnum, col, text = line:match(error_pattern)
      local qftype = 'E'

      if not filename then
        filename, lnum, col, text = line:match(warn_pattern)
        qftype = 'W'
      end

      if filename then
        table.insert(qfitems, {
          filename = root .. '/' .. filename,
          lnum = tonumber(lnum),
          col = tonumber(col),
          text = text,
          type = qftype,
        })
      end
    end

    vim.schedule(function()
      if #qfitems == 0 then
        vim.notify('tsc: no errors found', vim.log.levels.INFO)
        return
      end

      vim.fn.setqflist({}, 'r', { title = 'Type Check', items = qfitems })
      require('trouble').open 'qflist'
    end)
  end)
end, { desc = 'tsc' })
