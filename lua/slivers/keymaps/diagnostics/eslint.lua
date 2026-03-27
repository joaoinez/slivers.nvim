local map = Slivers.keymaps.safe_keymap_set

local default_cmd = { 'npx', 'eslint', '--cache' }

local function run_lint(root, base, is_fallback)
  local cmd = vim.list_extend(vim.list_slice(base), { '--format', 'json' })

  vim.notify('Running ' .. table.concat(cmd, ' '), vim.log.levels.INFO)

  vim.system(cmd, { cwd = root, text = true }, function(result)
    local output = result.stdout or ''

    vim.schedule(function()
      if result.code == 2 then
        if not is_fallback and vim.g.q_ts_lint_cmd then
          vim.notify('eslint: custom command failed, retrying with default', vim.log.levels.WARN)
          run_lint(root, default_cmd, true)
        else
          vim.notify('eslint: ' .. (result.stderr or output), vim.log.levels.ERROR)
        end
        return
      end

      local ok, decoded = pcall(vim.json.decode, output)
      if not ok or type(decoded) ~= 'table' then
        if not is_fallback and vim.g.q_ts_lint_cmd then
          vim.notify('eslint: custom command failed to parse output, retrying with default', vim.log.levels.WARN)
          run_lint(root, default_cmd, true)
        else
          vim.notify('eslint: failed to parse output', vim.log.levels.ERROR)
        end
        return
      end

      local qfitems = {}

      for _, file_result in ipairs(decoded) do
        local filepath = file_result.filePath
        for _, msg in ipairs(file_result.messages or {}) do
          local qftype = msg.severity == 1 and 'W' or 'E'
          local text = msg.message
          if msg.ruleId then text = '[' .. msg.ruleId .. '] ' .. text end
          table.insert(qfitems, {
            filename = filepath,
            lnum = msg.line or 1,
            col = msg.column or 1,
            text = text,
            type = qftype,
          })
        end
      end

      if #qfitems == 0 then
        vim.notify('eslint: no errors found', vim.log.levels.INFO)
        return
      end

      vim.fn.setqflist({}, 'r', { title = 'Lint', items = qfitems })
      require('trouble').open 'qflist'
    end)
  end)
end

map('n', '<leader>qpe', function()
  local root = Snacks.git.get_root()
  if not root then
    vim.notify('Could not determine project root', vim.log.levels.ERROR)
    return
  end

  local base = vim.g.q_ts_lint_cmd or default_cmd
  run_lint(root, base, false)
end, { desc = 'eslint' })
