local M = {}

M.colorschemes = {
  _fallback = {
    hl_groups = function() return require 'slivers.colorscheme._fallback' end,
  },
  ashen = require 'slivers.colorscheme.ashen',
  ayu = require 'slivers.colorscheme.ayu',
  catppuccin = require 'slivers.colorscheme.catppuccin',
  cyberdream = require 'slivers.colorscheme.cyberdream',
  default = require 'slivers.colorscheme.default',
  gruvbox = require 'slivers.colorscheme.gruvbox',
  kanagawa = require 'slivers.colorscheme.kanagawa',
  onedark = require 'slivers.colorscheme.onedark',
  poimandres = require 'slivers.colorscheme.poimandres',
  ['rose-pine'] = require 'slivers.colorscheme.rose-pine',
  tokyonight = require 'slivers.colorscheme.tokyonight',
  vague = require 'slivers.colorscheme.vague',
}

function M.apply()
  local colorscheme = Slivers.colorscheme.get_config(M.colorschemes, vim.g.colors_name)

  -- [[ Set Highlight Groups ]]
  Slivers.colorscheme.set_hl_groups(colorscheme.hl_groups)

  -- [[ Apply Globals ]]
  Slivers.colorscheme.set_globals(colorscheme.globals)
end

return setmetatable(M, {
  __call = function(self) return self.apply() end,
})
