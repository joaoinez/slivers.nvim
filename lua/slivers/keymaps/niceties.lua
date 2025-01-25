local map = Slivers.keymaps.safe_keymap_set

if not vim.g.vscode then
  -- Move Lines
  map('n', '<A-j>', "<cmd>execute 'move .+' . v:count1<cr>==", { desc = 'Move Down' })
  map('n', '<A-k>', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = 'Move Up' })
  map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
  map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
  map('v', '<A-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = 'Move Down' })
  map('v', '<A-k>', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = 'Move Up' })

  -- Toggle comments
  map({ 'n', 'x' }, '<leader>/', '<cmd>norm gcc<cr>', { desc = 'Toggle comment line' })

  -- Save and quit Neovim
  map('n', '<leader>x', '<cmd>wqa<cr>', { desc = 'Save and Quit Neovim' })
end

-- Save file
map('n', '<leader>s', '<cmd>w<cr>', { desc = 'Save File' })

-- Use ESC to clear hlsearch, while preserving its original functionality.
map('n', '<ESC>', function()
  if vim.fn.hlexists 'Search' then
    vim.cmd 'nohlsearch'
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<ESC>', true, true, true), 'n', true)
  end
end)

-- Add comments above and below current line
map('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Below' })
map('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', { desc = 'Add Comment Above' })

-- Improved tabulation
map('x', '<S-Tab>', '<gv', { desc = 'unindent line' })
map('x', '<Tab>', '>gv', { desc = 'indent line' })
map('x', '<', '<gv', { desc = 'unindent line' })
map('x', '>', '>gv', { desc = 'indent line' })

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

-- Open slivers.json file
map('n', '<leader>,o', function()
  -- TODO: Simplify this. The math.floor stuff should be inside create_floating_window
  local width = math.floor(vim.o.columns * 0.25)
  local window = Slivers.misc.create_floating_window {
    width = width,
    height = math.floor(vim.o.lines * 0.25),
    win = {
      title = 'Options',
      row = 0,
      col = math.floor(vim.o.columns * 0.99) - width,
    },
  }

  vim.api.nvim_set_current_buf(window.buf)
  vim.cmd('e ' .. vim.fn.stdpath 'config' .. '/.slivers.json')
  vim.api.nvim_buf_set_keymap(window.buf, 'n', 'q', '<cmd>x<cr>', { noremap = true, silent = true })
end, { desc = 'Options' })

-- Source file
map('n', '<leader>ks', '<cmd>source %<cr>', { desc = 'Source File' })

-- Test file with Plenary
map('n', '<leader>kt', '<cmd>PlenaryBustedFile %<cr>', { desc = 'Test File (plenary)' })
