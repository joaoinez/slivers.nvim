local map = Slivers.keymaps.safe_keymap_set

map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Move windows in terminal mode
map('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Move focus to the left window' })
map('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = 'Move focus to the lower window' })
map('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = 'Move focus to the upper window' })
map('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = 'Move focus to the right window' })

-- REPL node
map('n', '<leader>krn', function() Slivers.misc.open_term_with_cmd 'node' end, { desc = 'Node' })

-- REPL lua
map('n', '<leader>krl', function() Slivers.misc.open_term_with_cmd 'lua' end, { desc = 'Lua' })

-- REPL python
map('n', '<leader>krp', function() Slivers.misc.open_term_with_cmd 'python3' end, { desc = 'Python' })
