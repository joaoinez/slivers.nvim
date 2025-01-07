local M = {}

M.colorschemes = {
  _fallback = {
    hl_groups = function() return require 'slivers.colorscheme._fallback' end,
  },
  catppuccin = require 'slivers.colorscheme.catppuccin',
  default = require 'slivers.colorscheme.default',
  gruvbox = require 'slivers.colorscheme.gruvbox',
  kanagawa = require 'slivers.colorscheme.kanagawa',
  onedark = require 'slivers.colorscheme.onedark',
  ['rose-pine'] = require 'slivers.colorscheme.rose-pine',
  tokyonight = require 'slivers.colorscheme.tokyonight',
}

M.random_colorschemes = {
  'catppuccin',
  'default',
  'kanagawa',
  'onedark',
  'tokyonight',
  'rose-pine',
}

function M.apply()
  -- [[ Apply Colorscheme ]]
  vim.cmd.colorscheme(vim.g.colorscheme)

  local colorscheme = Slivers.colorscheme.get_config(M.colorschemes, vim.g.colorscheme)

  -- [[ Set Highlight Groups ]]
  Slivers.colorscheme.set_hl_groups(colorscheme.hl_groups)

  -- [[ Apply Globals ]]
  Slivers.colorscheme.set_globals(colorscheme.globals)
end

return setmetatable(M, {
  __call = function(self) return self.apply() end,
})
