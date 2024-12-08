--   [[ Keybindings Reference ]]
--   -------------------------------------------------------------------
--   |        Mode  | Norm | Ins | Cmd | Vis | Sel | Opr | Term | Lang |
--   Command        +------+-----+-----+-----+-----+-----+------+------+
--   [nore]map      | yes  |  -  |  -  | yes | yes | yes |  -   |  -   |
--   n[nore]map     | yes  |  -  |  -  |  -  |  -  |  -  |  -   |  -   |
--   [nore]map!     |  -   | yes | yes |  -  |  -  |  -  |  -   |  -   |
--   i[nore]map     |  -   | yes |  -  |  -  |  -  |  -  |  -   |  -   |
--   c[nore]map     |  -   |  -  | yes |  -  |  -  |  -  |  -   |  -   |
--   v[nore]map     |  -   |  -  |  -  | yes | yes |  -  |  -   |  -   |
--   x[nore]map     |  -   |  -  |  -  | yes |  -  |  -  |  -   |  -   |
--   s[nore]map     |  -   |  -  |  -  |  -  | yes |  -  |  -   |  -   |
--   o[nore]map     |  -   |  -  |  -  |  -  |  -  | yes |  -   |  -   |
--   t[nore]map     |  -   |  -  |  -  |  -  |  -  |  -  | yes  |  -   |
--   l[nore]map     |  -   | yes | yes |  -  |  -  |  -  |  -   | yes  |
--   -------------------------------------------------------------------

-- [[ Map Shorthand ]]
local utils = require 'utils'
local maps = utils.get_mappings_template()

-- [[ Keymaps ]]
maps.n['j'] =
  { "v:count == 0 ? 'gj' : 'j'", expr = true, desc = 'Move cursor down' }
maps.n['k'] =
  { "v:count == 0 ? 'gk' : 'k'", expr = true, desc = 'Move cursor up' }
maps.n['<leader>s'] = { '<cmd>w<cr>', desc = 'Save File' }
maps.n['<leader>x'] = { '<cmd>wqa<cr>', desc = 'Save and Quit Neovim' }
maps.n['<leader>/'] = { 'gcc', remap = true, desc = 'Toggle comment line' }
maps.x['<leader>/'] = { 'gc', remap = true, desc = 'Toggle comment' }
-- maps.n['<leader>qq'] = {
--   function()
--     -- Ask user for confirmation
--     local choice =
--       vim.fn.confirm('Do you really want to exit nvim?', '&Yes\n&No', 2)
--     if choice == 1 then
--       -- If user confirms, but there are still files to be saved: Ask
--       vim.cmd 'confirm quit'
--     end
--   end,
--   desc = 'Quit',
-- }
maps.n['<Tab>'] = {
  '<Tab>',
  noremap = true,
  silent = true,
  expr = false,
  desc = 'FIX: Prevent TAB from behaving like <C-i>, as they share the same internal code',
}
-- Make 'c' key not copy to clipboard when changing a character.
maps.n['c'] = { '"_c', desc = 'Change without yanking' }
maps.n['C'] = { '"_C', desc = 'Change without yanking' }
maps.x['c'] = { '"_c', desc = 'Change without yanking' }
maps.x['C'] = { '"_C', desc = 'Change without yanking' }

-- Make 'x' key not copy to clipboard when deleting a character.
maps.n['x'] = {
  -- Also let's allow 'x' key to delete blank lines in normal mode.
  function()
    if vim.fn.col '.' == 1 then
      local line = vim.fn.getline '.'
      if line:match '^%s*$' then
        vim.api.nvim_feedkeys('"_dd', 'n', false)
        vim.api.nvim_feedkeys('$', 'n', false)
      else
        vim.api.nvim_feedkeys('"_x', 'n', false)
      end
    else
      vim.api.nvim_feedkeys('"_x', 'n', false)
    end
  end,
  desc = 'Delete character without yanking it',
}
maps.x['x'] = { '"_x', desc = 'Delete all characters in line' }

-- Same for shifted X
maps.n['X'] = {
  -- Also let's allow 'x' key to delete blank lines in normal mode.
  function()
    if vim.fn.col '.' == 1 then
      local line = vim.fn.getline '.'
      if line:match '^%s*$' then
        vim.api.nvim_feedkeys('"_dd', 'n', false)
        vim.api.nvim_feedkeys('$', 'n', false)
      else
        vim.api.nvim_feedkeys('"_X', 'n', false)
      end
    else
      vim.api.nvim_feedkeys('"_X', 'n', false)
    end
  end,
  desc = 'Delete before character without yanking it',
}
maps.x['X'] = { '"_X', desc = 'Delete all characters in line' }

-- Override nvim default behavior so it doesn't auto-yank when pasting on visual mode.
maps.x['p'] = { 'P', desc = "Paste content you've previourly yanked" }
maps.x['P'] = { 'p', desc = 'Yank what you are going to override, then paste' }

-- search highlighting ------------------------------------------------------
-- use ESC to clear hlsearch, while preserving its original functionality.
--
-- TIP: If you prefer,  use <leader>ENTER instead of <ESC>
--      to avoid triggering it by accident.
maps.n['<ESC>'] = {
  function()
    if vim.fn.hlexists 'Search' then
      vim.cmd 'nohlsearch'
    else
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes('<ESC>', true, true, true),
        'n',
        true
      )
    end
  end,
}

utils.set_mappings(maps)

-- map('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- map('n', '<leader>s', '<cmd>w<cr>')
-- map('n', '<leader>x', '<cmd>xa<cr>')
-- -- Keybinds to make split navigation easier.
-- --  Use CTRL+<hjkl> to switch between windows
-- --
-- --  See `:help wincmd` for a list of all window commands
-- vim.keymap.set(
--   'n',
--   '<C-h>',
--   '<C-w><C-h>',
--   { desc = 'Move focus to the left window' }
-- )
-- vim.keymap.set(
--   'n',
--   '<C-l>',
--   '<C-w><C-l>',
--   { desc = 'Move focus to the right window' }
-- )
-- vim.keymap.set(
--   'n',
--   '<C-j>',
--   '<C-w><C-j>',
--   { desc = 'Move focus to the lower window' }
-- )
-- vim.keymap.set(
--   'n',
--   '<C-k>',
--   '<C-w><C-k>',
--   { desc = 'Move focus to the upper window' }
-- )
-- -- Diagnostic keymaps
-- vim.keymap.set(
--   'n',
--   '<leader>q',
--   vim.diagnostic.setloclist,
--   { desc = 'Open diagnostic [Q]uickfix list' }
-- )
