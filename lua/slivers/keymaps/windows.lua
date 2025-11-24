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

  -- Focus floating windows
  map('n', '<leader>wf', '<C-w>w', { desc = 'Focus Floating' })

  -- Close floating windows
  map('n', '<leader>wF', '<cmd>fc<cr>', { desc = 'Close Floating' })

  -- Splits
  map('n', '<leader>|', function()
    vim.cmd 'vsplit'

    -- // TODO: Reuse this function
    Snacks.picker.files {
      hidden = true,
      matcher = {
        frecency = true,
      },
      win = {
        preview = {
          footer = '┤ <a-h> hidden │ <a-i> ignored │ <a-s> flash │ <a-g> refine ├ ',
          footer_pos = 'right',
        },
      },
    }
  end, { desc = 'Vertical Split' })
  map('n', '<leader>\\', function()
    vim.cmd 'split'

    -- // TODO: Reuse this function
    Snacks.picker.files {
      hidden = true,
      matcher = {
        frecency = true,
      },
      win = {
        preview = {
          footer = '┤ <a-h> hidden │ <a-i> ignored │ <a-s> flash │ <a-g> refine ├ ',
          footer_pos = 'right',
        },
      },
    }
  end, { desc = 'Horizontal Split' })
  map('n', '<leader>ws', '<C-w>r', { desc = 'Swap Splits' })
  map('n', '<leader>w\\', '<C-w>|', { desc = 'Max Out Split Width' })
  map('n', '<leader>w|', '<C-w>_', { desc = 'Max Out Split Height' })
  map('n', '<leader>wm', function()
    vim.cmd 'wincmd _'
    vim.cmd 'wincmd |'
  end, { desc = 'Maximise Split' })
  map('n', '<leader>we', '<C-w>=', { desc = 'Equal Out Splits' })
  map('n', '<leader>wo', '<C-w>o', { desc = 'Close Other Splits' })
  map('n', '<leader>wh', '<C-w>H', { desc = 'Move Split Left' })
  map('n', '<leader>wj', '<C-w>J', { desc = 'Move Split Down' })
  map('n', '<leader>wk', '<C-w>K', { desc = 'Move Split Up' })
  map('n', '<leader>wl', '<C-w>L', { desc = 'Move Split Right' })

  -- Tabs
  map(
    'n',
    '<leader>wT',
    '<cmd>tabnew | lua Snacks.picker.files { hidden = true, matcher = { frecency = true }, auto_confirm = true }<cr>',
    { desc = 'New Tab' }
  )
  map('n', '<leader>ww', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
  map('n', '<leader>wn', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
  map('n', '<leader>wp', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })
  map('n', '<leader>wt', '<C-w>T', { desc = 'Send to Tab' })
end
