local map = Slivers.keymaps.safe_keymap_set

local function toggle_tiny_terminal()
  local in_tmux = vim.fn.exists '$TMUX' == 1
  if not in_tmux then
    vim.notify('Not running inside tmux', vim.log.levels.WARN)
    return
  end

  local pane_count_str = vim.fn.system("tmux display-message -p '#{window_panes}'"):gsub('%s+', '')
  local is_zoomed_str = vim.fn.system("tmux display-message -p '#{window_zoomed_flag}'"):gsub('%s+', '')

  local pane_count = tonumber(pane_count_str)
  local is_zoomed = tonumber(is_zoomed_str) == 1

  if not pane_count then
    vim.notify('Failed to get pane count: ' .. pane_count_str, vim.log.levels.ERROR)
    return
  end

  if pane_count > 1 then
    if is_zoomed then
      vim.fn.system 'tmux select-pane -D'
    else
      vim.fn.system 'tmux resize-pane -Z'
    end
  else
    vim.fn.system 'tmux split-window -v -l 14'
  end
end

-- Map both key variations to the toggle function
map('n', '<C-/>', toggle_tiny_terminal, { desc = 'Toggle Tiny Terminal' })
map('n', '<C-_>', toggle_tiny_terminal, { desc = 'which_key_ignore' })

-- Map for opening aider in a right pane
map('n', '<leader>ai', function()
  local in_tmux = vim.fn.exists '$TMUX' == 1
  if not in_tmux then
    vim.notify('Not running inside tmux', vim.log.levels.WARN)
    return
  end

  vim.fn.system 'tmux split-window -h -p 30 "aider --watch-files"'
end, { desc = 'Aider' })
