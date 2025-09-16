--[[
=====================================================================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||    slivers.nvim    ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:q                  ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================
--]]

-- [[ Add File Extensions ]]
vim.filetype.add {
  extension = {
    http = 'http',
    ['code-snippets'] = 'jsonc',
    razor = 'razor',
    cshtml = 'razor',
  },
}

-- [[ Set Globals ]]
_G.Slivers = require 'slivers.utils'
_G.LangSliver = require 'slivers.lang'
_G.IconSliver = require 'slivers.icons'
_G.ColorSliver = require 'slivers.colorscheme'

-- [[ Load Options ]]
Slivers.load 'options'

-- [[ Load Tabline ]]
Slivers.load 'tabline'

-- [[ Initialize Lazy ]]
Slivers.load 'lazy'

-- autocmds can be loaded lazily when not opening a file
local lazy_autocmds = vim.fn.argc(-1) == 0
if not lazy_autocmds then
  -- [[ Load Autocmds ]]
  Slivers.load 'autocmds'
end

-- Lazily load autocmds and keymaps
local group = vim.api.nvim_create_augroup('LazySlivers', { clear = true })
vim.api.nvim_create_autocmd('User', {
  group = group,
  pattern = 'VeryLazy',
  callback = function()
    if lazy_autocmds then
      -- [[ Load Autocmds ]]
      Slivers.load 'autocmds'
    end
    -- [[ Load Keymaps ]]
    Slivers.load 'keymaps'
  end,
})

-- [[ Load VSCode Config ]]
if vim.g.vscode then Slivers.load 'vscode' end

-- [[ Load Colorscheme ]]
if not vim.g.vscode then
  vim.cmd('colorscheme ' .. vim.g.colorscheme)

  ColorSliver()
end

-- vim: ts=2 sts=2 sw=2 et
