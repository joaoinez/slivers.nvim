local map = Slivers.keymaps.safe_keymap_set

-- TODO: Make these docstrings with keybindings consistent
--
--  Use CTRL+<hjkl> to switch between windows
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })

-- resize window using <ctrl> alt hjkl
map('n', '<C-M-k>', '<cmd>resize +2<cr>', { desc = 'increase window height' })
map('n', '<C-M-j>', '<cmd>resize -2<cr>', { desc = 'decrease window height' })
map('n', '<C-M-l>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })
map('n', '<C-M-h>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })

-- Splits
map('n', '<leader>|', '<cmd>vsplit<cr>', { desc = 'Vertical Split' })
map('n', '<leader>\\', '<cmd>split<cr>', { desc = 'Horizontal Split' })

-- Switch between the last opened buffer
map('n', '<leader><Tab>', '<cmd>b#<cr>', { desc = 'Last Opened Buffer' })

-- Close current window
map('n', '<leader>wq', '<cmd>q!<cr>', { desc = 'Close' })

-- Close all windows
map('n', '<leader>wa', '<cmd>qa!<cr>', { desc = 'Close All' })

-- Close floating windows
map('n', '<leader>wf', '<cmd>fc<cr>', { desc = 'Close Floating' })

-- Swap splits
map('n', '<leader>ws', '<C-w>r', { desc = 'Swap Splits' })

-- Max out split width
map('n', '<leader>ww', '<C-w>|', { desc = 'Max Out Split Width' })

-- Max out split height
map('n', '<leader>wh', '<C-w>_', { desc = 'Max Out Split Height' })

-- Equal out splits
map('n', '<leader>we', '<C-w>=', { desc = 'Equal Out Splits' })
