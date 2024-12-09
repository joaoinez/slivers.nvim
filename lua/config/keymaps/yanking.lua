local utils = require 'utils'
local maps = utils.get_mappings_template()

-- Copy entire file
maps.n['<leader>y'] = { 'gg0yG', desc = 'Yank File' }

-- Duplicate line
maps.n['yd'] = { '<cmd>norm yy<cr>p', desc = 'Duplicate line' }

-- Duplicate line and comment the original
maps.n['yc'] = { '<cmd>norm yygcc<cr>p', desc = 'Duplicate line and comment original' }

-- Remap default yank in visual mode to yy for faster yanks
maps.x['yy'] = { 'y', desc = 'Yank selection' }

-- Dupicate text selection
-- maps.v['yd'] = { 'ygv`>p', remap = true, desc = 'Duplicate selection' }

-- Duplicate selection and comment the original
maps.x['yc'] = {
  'ygvgc`>p',
  remap = true,
  desc = 'Duplicate selection and comment original',
}

-- Select recently pasted, yanked or changed text
maps.n['gy'] = { '`[v`]', desc = 'Select recently pasted, yanked or changed text' }

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

-- Delete all characters in line
maps.x['X'] = { '"_X', desc = 'Delete all characters in line' }

-- Override nvim default behavior so it doesn't auto-yank when pasting on visual mode.
maps.x['p'] = { 'P', desc = "Paste content you've previourly yanked" }
maps.x['P'] = { 'p', desc = 'Yank what you are going to override, then paste' }

utils.set_mappings(maps)
