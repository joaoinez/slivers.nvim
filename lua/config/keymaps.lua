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

local utils = require 'utils'
local maps = utils.get_mappings_template()

-- [[ Keymaps ]]
maps.n['j'] =
  { "v:count == 0 ? 'gj' : 'j'", expr = true, desc = 'Move cursor down' }
maps.n['k'] =
  { "v:count == 0 ? 'gk' : 'k'", expr = true, desc = 'Move cursor up' }
maps.n['<leader>/'] = { 'gcc', remap = true, desc = 'Toggle comment line' }
maps.x['<leader>/'] = { 'gc', remap = true, desc = 'Toggle comment' }
maps.n['<Tab>'] = {
  '<Tab>',
  noremap = true,
  silent = true,
  expr = false,
  desc = 'FIX: Prevent TAB from behaving like <C-i>, as they share the same internal code',
}
maps.n['|'] = { '<cmd>vsplit<cr>', desc = 'Vertical Split' }
maps.n['\\'] = { '<cmd>split<cr>', desc = 'Horizontal Split' }
maps.n['<leader>s'] = { '<cmd>w<cr>', desc = 'Save File' }
maps.n['<leader>x'] = { '<cmd>wqa<cr>', desc = 'Save and Quit Neovim' }
maps.n['yc'] =
  { '<cmd>norm yygcc<cr>p', desc = 'Duplicate line and comment original' }
maps.n['<leader>dy'] = { 'gg0yG', desc = 'Yank File' }

-- Page jumping centers cursor
maps.n['<C-d>'] =
  { '<C-d>zz', desc = 'Scrolls down the page and center the cursor' }
maps.n['<C-u>'] =
  { '<C-u>zz', desc = 'Scrolls up the page and center the cursor' }

-- Search centers cursor
maps.n['n'] =
  { 'nzzzv', desc = 'Jump to next search result and center the cursor' }
maps.n['N'] =
  { 'Nzzzv', desc = 'Jump to previous search result and center the cursor' }

--  Use CTRL+<hjkl> to switch between windows
maps.n['<C-h>'] = {
  '<C-w><C-h>',
  desc = 'Move focus to the left window',
}
maps.n['<C-j>'] = {
  '<C-w><C-j>',
  desc = 'Move focus to the lower window',
}
maps.n['<C-k>'] = {
  '<C-w><C-k>',
  desc = 'Move focus to the upper window',
}
maps.n['<C-l>'] = {
  '<C-w><C-l>',
  desc = 'Move focus to the right window',
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

-- use ESC to clear hlsearch, while preserving its original functionality.
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

-- Disable arrow keys in normal mode
maps.n['<left>'] = { '<nop>' }
maps.n['<down>'] = { '<nop>' }
maps.n['<up>'] = { '<nop>' }
maps.n['<right>'] = { '<nop>' }

maps.n['s'] = { '<nop>' }
maps.v['s'] = { '<nop>' }

utils.set_mappings(maps)
