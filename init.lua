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

_G.Slivers = require 'slivers.utils'
_G.LangSliver = require 'slivers.lang'
_G.IconSliver = require 'slivers.icons'

-- [[ Load Options ]]
Slivers.load 'options'

-- [[ Initialize Lazy ]]
require 'slivers.lazy'

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

-- [[ Apply Colorscheme ]]
vim.cmd.colorscheme 'catppuccin'

-- vim: ts=2 sts=2 sw=2 et
