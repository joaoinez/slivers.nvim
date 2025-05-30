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

-- Open Codex
map('n', '<leader>ax', function()
  local in_tmux = vim.fn.exists '$TMUX' == 1
  if not in_tmux then
    vim.notify('Not running inside tmux', vim.log.levels.WARN)
    return
  end

  vim.fn.system 'tmux split-window -h -p 40 "codex --provider openrouter"'
end, { desc = 'Codex' })

-- Open AI Chat
map('n', '<leader>ao', function()
  local in_tmux = vim.fn.exists '$TMUX' == 1
  if not in_tmux then
    vim.notify('Not running inside tmux', vim.log.levels.WARN)
    return
  end

  vim.fn.system 'tmux split-window -h -p 40 "aichat"'
end, { desc = 'AI Chat (deepseek-r1)' })
