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

-- Move Lines
map('n', '<A-j>', "<cmd>execute 'move .+' . v:count1<cr>==", { desc = 'Move Down' })
map('n', '<A-k>', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = 'Move Up' })
map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
map('v', '<A-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = 'Move Down' })
map('v', '<A-k>', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = 'Move Up' })
-- Save file
map('n', '<leader>s', '<cmd>w<cr>', { desc = 'Save File' })

-- Save and quit Neovim
map('n', '<leader>x', '<cmd>wqa<cr>', { desc = 'Save and Quit Neovim' })

-- Use ESC to clear hlsearch, while preserving its original functionality.
map('n', '<ESC>', function()
  if vim.fn.hlexists 'Search' then
    vim.cmd 'nohlsearch'
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<ESC>', true, true, true), 'n', true)
  end
end)

-- Toggle comments
map({ 'n', 'x' }, '<leader>/', '<cmd>norm gcc<cr>', { desc = 'Toggle comment line' })

-- Improved tabulation
map('x', '<S-Tab>', '<gv', { desc = 'unindent line' })
map('x', '<Tab>', '>gv', { desc = 'indent line' })
map('x', '<', '<gv', { desc = 'unindent line' })
map('x', '>', '>gv', { desc = 'indent line' })

-- Splits
map('n', '<leader>|', '<cmd>vsplit<cr>', { desc = 'Vertical Split' })
map('n', '<leader>\\', '<cmd>split<cr>', { desc = 'Horizontal Split' })

-- Enable `<C-backspace>` to delete
map('i', '<C-BS>', '<C-W>', { desc = 'Enable `<C-backspace>` to delete.' })

-- Block insert in line visual mode
map('x', 'I', function() return vim.fn.mode() == 'V' and '^<C-v>I' or 'I' end, { expr = true })
map('x', 'A', function() return vim.fn.mode() == 'V' and '$<C-v>A' or 'A' end, { expr = true })

-- From the Vim wiki: https://bit.ly/4eLAARp
-- Search and replace word under the cursor
map('n', '<leader>cW', [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { desc = 'Rename Word' })

-- Diagnostic keymap
-- map('n', '<leader>qQ', vim.diagnostic.setloclist, { desc = 'Diagnostic Quickfix List' })
map('n', '<leader>ql', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })

-- Keywordprg
map('n', '<leader>kk', '<cmd>norm! K<cr>', { desc = 'Keywordprg' })

-- Inspect Tree
map('n', '<leader>cI', '<cmd>InspectTree<cr>', { desc = 'Inspect Tree' })

-- Terminal Mappings
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('t', '<C-/>', '<cmd>close<cr>', { desc = 'Hide Terminal' })
map('t', '<C-_>', '<cmd>close<cr>', { desc = 'which_key_ignore' })
map('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Move focus to the left window' })
map('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = 'Move focus to the lower window' })
map('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = 'Move focus to the upper window' })
map('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = 'Move focus to the right window' })

-- File explorer (oil or fallback on default)
map('n', '<leader>fe', function() Slivers.actions.explore() end, { desc = 'File Explorer' })

-- Switch between the last opened buffer
map('n', '<leader><Tab>', '<cmd>b#<cr>', { desc = 'Last Opened Buffer' })

-- Lazy
map('n', '<leader>,l', function() require('lazy').check() end, { desc = 'Lazy' })

-- Mason
if Slivers.lazy.is_available 'mason.nvim' then
  map('n', '<leader>,m', '<cmd>Mason<cr>', { desc = 'Mason' })
  map('n', '<leader>,M', '<cmd>MasonToolsUpdate<cr>', { desc = 'Mason Update' })
end

-- Treesitter
if Slivers.lazy.is_available 'nvim-treesitter' then
  map('n', '<leader>,t', '<cmd>TSInstallInfo<cr>', { desc = 'Treesitter' })
  map('n', '<leader>,T', '<cmd>TSUpdate<cr>', { desc = 'Treesitter Update' })
end

-- Update lazy, mason and treesitter
map('n', '<leader>,U', '<cmd>UpdateEverything<cr>', { desc = 'Update Everything' })

-- Clear all marks
map('n', '<leader>,C', '<cmd>delm! | delm A-Z0-9<cr>jk', { desc = 'Clear All Marks' })

-- Commenting
map('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Below' })
map('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' })

-- Close current buffer
map('n', '<leader>kq', '<cmd>q!<cr>', { desc = 'Close Window' })

-- Close all buffers
map('n', '<leader>ka', '<cmd>qa!<cr>', { desc = 'Close All Windows' })

-- Open slivers.json file
map('n', '<leader>,o', function()
  local window = Slivers.misc.create_floating_window {
    -- TODO: Simplify this. The math.floor stuff should be inside create_floating_window
    width = math.floor(vim.o.columns * 0.33),
    height = math.floor(vim.o.lines * 0.33),
    win = { title = 'Options' },
  }

  vim.api.nvim_set_current_buf(window.buf)
  vim.cmd('e ' .. vim.fn.stdpath 'config' .. '/.slivers.json')
  vim.api.nvim_buf_set_keymap(window.buf, 'n', 'q', '<cmd>x<cr>', { noremap = true, silent = true })
end, { desc = 'Options' })

-- Source file
map('n', '<leader>,%', '<cmd>source %<cr>', { desc = 'Source File' })

-- REPL node
map('n', '<leader>krn', function() Slivers.misc.open_term_with_cmd 'node' end, { desc = 'Node' })

-- REPL lua
map('n', '<leader>krl', function() Slivers.misc.open_term_with_cmd 'lua' end, { desc = 'Lua' })

-- REPL python
map('n', '<leader>krp', function() Slivers.misc.open_term_with_cmd 'python3' end, { desc = 'Python' })

-- Toggle aider
map('n', '<leader>aA', function() Slivers.misc.open_term_with_cmd 'aider' end, { desc = 'Aider' })
