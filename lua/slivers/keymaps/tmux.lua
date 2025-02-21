local map = Slivers.keymaps.safe_keymap_set

-- State tracking for tiny terminal toggle (cycles through states 0-3)
local toggle_state = 0

local function toggle_tiny_terminal()
  if toggle_state == 0 then
    -- First press: Initialize tiny terminal
    vim.fn.system '~/.local/bin/tmux-tiny-terminal.sh'
    toggle_state = 1
  elseif toggle_state == 1 then
    -- Second press: Hide terminal with tmux zoom
    vim.fn.system 'tmux resize-pane -Z'
    toggle_state = 2
  else
    -- Third press: Show terminal by moving to it (auto-unzooms)
    vim.fn.system 'tmux select-pane -D'
    toggle_state = 1
  end
end

-- Map both key variations to the toggle function
map('n', '<C-/>', toggle_tiny_terminal, { desc = 'Toggle Tiny Terminal' })
map('n', '<C-_>', toggle_tiny_terminal, { desc = 'which_key_ignore' })
