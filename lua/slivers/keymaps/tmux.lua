local map = Slivers.keymaps.safe_keymap_set

-- Improved terminal toggle with tmux pane awareness
local function toggle_tiny_terminal()
  -- Check if we're in tmux
  local in_tmux = vim.fn.exists '$TMUX' == 1
  if not in_tmux then
    vim.notify('Not running inside tmux', vim.log.levels.WARN)
    return
  end

  -- Get information about current tmux state
  local pane_count_str = vim.fn.system("tmux display-message -p '#{window_panes}'"):gsub('%s+', '')
  local is_zoomed_str = vim.fn.system("tmux display-message -p '#{window_zoomed_flag}'"):gsub('%s+', '')

  -- Convert to numbers safely
  local pane_count = tonumber(pane_count_str)
  local is_zoomed = tonumber(is_zoomed_str) == 1

  -- Check for valid values
  if not pane_count then
    vim.notify('Failed to get pane count: ' .. pane_count_str, vim.log.levels.ERROR)
    return
  end

  if pane_count > 1 then
    -- Multiple panes exist
    if is_zoomed then
      -- Current pane is zoomed, navigate to pane below
      vim.fn.system 'tmux select-pane -D'
    else
      -- Current pane is not zoomed, zoom it
      vim.fn.system 'tmux resize-pane -Z'
    end
  else
    -- Only one pane exists, create tiny terminal
    vim.fn.system 'tmux split-window -v -l 14'
  end
end

-- Map both key variations to the toggle function
map('n', '<C-/>', toggle_tiny_terminal, { desc = 'Toggle Tiny Terminal' })
map('n', '<C-_>', toggle_tiny_terminal, { desc = 'which_key_ignore' })
