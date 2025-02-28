local map = Slivers.keymaps.safe_keymap_set

-- Oper Aider
map('n', '<leader>ai', function()
  local in_tmux = vim.fn.exists '$TMUX' == 1
  if not in_tmux then
    vim.notify('Not running inside tmux', vim.log.levels.WARN)
    return
  end

  vim.fn.system 'tmux split-window -h -p 40 "aider --architect"'
end, { desc = 'Aider' })

-- Oper Claude Code
map('n', '<leader>ac', function()
  local in_tmux = vim.fn.exists '$TMUX' == 1
  if not in_tmux then
    vim.notify('Not running inside tmux', vim.log.levels.WARN)
    return
  end

  vim.fn.system 'tmux split-window -h -p 40 "claude"'
end, { desc = 'Claude Code' })
