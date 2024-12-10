local utils = require 'utils'
local maps = utils.get_mappings_template()

-- Better up/down
maps.n['j'] = { "v:count == 0 ? 'gj' : 'j'", expr = true, desc = 'Move cursor down' }
maps.x['j'] = { "v:count == 0 ? 'gj' : 'j'", expr = true, desc = 'Move cursor down' }
maps.n['k'] = { "v:count == 0 ? 'gk' : 'k'", expr = true, desc = 'Move cursor up' }
maps.x['k'] = { "v:count == 0 ? 'gk' : 'k'", expr = true, desc = 'Move cursor up' }

-- Page jumping centers cursor
maps.n['<C-d>'] = { '<C-d>zz', desc = 'Scrolls down the page and center the cursor' }
maps.n['<C-u>'] = { '<C-u>zz', desc = 'Scrolls up the page and center the cursor' }

-- Prevent Tab from behaving like `<C-i>`
maps.n['<Tab>'] = {
  '<Tab>',
  noremap = true,
  silent = true,
  expr = false,
  desc = 'Prevent Tab from behaving like <C-i>, as they share the same internal code',
}

-- From https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- Saner next and previous search behaviour
maps.n['n'] = { "'Nn'[v:searchforward].'zzzv'", expr = true, desc = 'Next Search Result' }
maps.x['n'] = { "'Nn'[v:searchforward]", expr = true, desc = 'Next Search Result' }
maps.o['n'] = { "'Nn'[v:searchforward]", expr = true, desc = 'Next Search Result' }
maps.n['N'] = { "'nN'[v:searchforward].'zzzv'", expr = true, desc = 'Prev Search Result' }
maps.x['N'] = { "'nN'[v:searchforward]", expr = true, desc = 'Prev Search Result' }
maps.o['N'] = { "'nN'[v:searchforward]", expr = true, desc = 'Prev Search Result' }

-- Better indenting
maps.v['<'] = { '<gv' }
maps.v['>'] = { '>gv' }

-- Improved gg
maps.n['gg'] = {
  function()
    if vim.v.count > 0 then
      vim.cmd('normal! ' .. vim.v.count .. 'gg')
    else
      vim.cmd 'normal! gg0'
    end
  end,
  desc = 'gg and go to the first position',
}
maps.n['G'] = {
  function() vim.cmd 'normal! G$' end,
  desc = 'G and go to the last position',
}
maps.x['gg'] = {
  function()
    if vim.v.count > 0 then
      vim.cmd('normal! ' .. vim.v.count .. 'gg')
    else
      vim.cmd 'normal! gg0'
    end
  end,
  desc = 'gg and go to the first position (visual)',
}
maps.x['G'] = {
  function() vim.cmd 'normal! G$' end,
  desc = 'G and go to the last position (visual)',
}
maps.n['<C-a>'] = { -- to move to the previous position press ctrl + oo
  function() vim.cmd 'normal! gg0vG$' end,
  desc = 'Visually select all',
}

-- Swaps `^` and `0` around
maps.n['0'] = { '^', desc = 'Go to the fist character of the line (aliases 0 to ^)' }
maps.n['^'] = { '0', desc = 'Go to the beginning of the line (aliases ^ to 0)' }

utils.set_mappings(maps)
