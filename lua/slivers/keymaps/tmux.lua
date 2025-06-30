local map = Slivers.keymaps.safe_keymap_set

-- Open Codex
map('n', '<leader>ax', function()
  local in_tmux = vim.fn.exists '$TMUX' == 1
  if not in_tmux then
    vim.notify('Not running inside tmux', vim.log.levels.WARN)
    return
  end

  vim.fn.system 'tmux split-window -h -p 40 "codex --provider openrouter"'
end, { desc = 'Codex' })
