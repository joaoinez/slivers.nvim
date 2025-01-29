local map = Slivers.keymaps.safe_keymap_set

if not vim.g.vscode then
  -- TODO: Make these docstrings with keybindings consistent
  --
  --  Use CTRL+<hjkl> to switch between windows
  map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
  map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })

  -- Resize window using <ctrl> alt hjkl
  map('n', '<C-M-k>', '<cmd>resize +2<cr>', { desc = 'increase window height' })
  map('n', '<C-M-j>', '<cmd>resize -2<cr>', { desc = 'decrease window height' })
  map('n', '<C-M-l>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })
  map('n', '<C-M-h>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })

  -- Switch between the last opened buffer
  map('n', '<leader><Tab>', '<cmd>b#<cr>', { desc = 'Last Opened Buffer' })

  -- Close current window
  map('n', '<leader>wq', '<cmd>q!<cr>', { desc = 'Close' })

  -- Close all windows
  map('n', '<leader>wa', '<cmd>qa!<cr>', { desc = 'Quit Neovim (without saving)' })

  -- Close floating windows
  map('n', '<leader>wf', '<cmd>fc<cr>', { desc = 'Close Floating' })

  -- Splits
  map(
    'n',
    '<leader>|',
    '<cmd>vsplit | FzfLua buffers sort_mru=true sort_lastused=true<cr>',
    { desc = 'Vertical Split' }
  )
  map(
    'n',
    '<leader>\\',
    '<cmd>split | FzfLua buffers sort_mru=true sort_lastused=true<cr>',
    { desc = 'Horizontal Split' }
  )
  map('n', '<leader>ws', '<C-w>r', { desc = 'Swap Splits' })
  map('n', '<leader>w\\', '<C-w>|', { desc = 'Max Out Split Width' })
  map('n', '<leader>w|', '<C-w>_', { desc = 'Max Out Split Height' })
  map('n', '<leader>we', '<C-w>=', { desc = 'Equal Out Splits' })
  map('n', '<leader>wo', '<C-w>o', { desc = 'Close Other Splits' })

  -- Tabs
  map('n', '<leader>wt', '<cmd>tabnew | FzfLua files<cr>', { desc = 'New Tab' })
  map('n', '<leader>ww', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
  map('n', '<leader>wn', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
  map('n', '<leader>wp', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })
  map('n', '<leader>wT', '<C-w>T', { desc = 'Send to Tab' })
end
