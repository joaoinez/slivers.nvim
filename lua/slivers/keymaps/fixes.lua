local map = Slivers.keymaps.safe_keymap_set

-- -- Better up/down
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = 'Move cursor down' })
map('x', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = 'Move cursor down' })
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = 'Move cursor up' })
map('x', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = 'Move cursor up' })

-- Page jumping centers cursor
map('n', '<C-d>', '<C-d>zz', { desc = 'Scrolls down the page and center the cursor' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Scrolls up the page and center the cursor' })

-- Prevent Tab from behaving like `<C-i>`
map('n', '<Tab>', '<Tab>', {
  noremap = true,
  silent = true,
  expr = false,
  desc = 'Prevent Tab from behaving like <C-i>, as they share the same internal code',
})

-- From https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- Saner next and previous search behaviour
map('n', 'n', "'Nn'[v:searchforward].'zzzv'", { expr = true, desc = 'Next Search Result' })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
map('n', 'N', "'nN'[v:searchforward].'zzzv'", { expr = true, desc = 'Prev Search Result' })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })

-- Better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Improved gg
map('n', 'gg', function()
  if vim.v.count > 0 then
    vim.cmd('normal! ' .. vim.v.count .. 'gg')
  else
    vim.cmd 'normal! gg0'
  end
end, {
  desc = 'gg and go to the first position',
})
map('n', 'G', function() vim.cmd 'normal! G$' end, { desc = 'G and go to the last position' })
map('x', 'gg', function()
  if vim.v.count > 0 then
    vim.cmd('normal! ' .. vim.v.count .. 'gg')
  else
    vim.cmd 'normal! gg0'
  end
end, {
  desc = 'gg and go to the first position (visual)',
})
map('x', 'G', function() vim.cmd 'normal! G$' end, { desc = 'G and go to the last position (visual)' })

-- to move to the previous position press ctrl + oo
map('n', '<C-a>', function() vim.cmd 'normal! gg0vG$' end, { desc = 'Visually select all' })

-- Swaps `^` and `0` around
map('n', '0', '^', { desc = 'Go to the fist character of the line (aliases 0 to ^)' })
map('n', '^', '0', { desc = 'Go to the beginning of the line (aliases ^ to 0)' })

-- Add undo break-points
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ';', ';<c-g>u')
