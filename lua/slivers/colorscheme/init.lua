local M = {}

M.colorschemes = {
  _fallback = {
    hl_groups = function() return require 'slivers.colorscheme._fallback' end,
  },
  ayu = require 'slivers.colorscheme.ayu',
  catppuccin = require 'slivers.colorscheme.catppuccin',
  cyberdream = require 'slivers.colorscheme.cyberdream',
  default = require 'slivers.colorscheme.default',
  github = require 'slivers.colorscheme.github',
  gruvbox = require 'slivers.colorscheme.gruvbox',
  islands = require 'slivers.colorscheme.islands',
  kanagawa = require 'slivers.colorscheme.kanagawa',
  nordic = require 'slivers.colorscheme.nordic',
  onedark = require 'slivers.colorscheme.onedark',
  oxocarbon = require 'slivers.colorscheme.oxocarbon',
  poimandres = require 'slivers.colorscheme.poimandres',
  ['rose-pine'] = require 'slivers.colorscheme.rose-pine',
  srcery = require 'slivers.colorscheme.srcery',
  techbase = require 'slivers.colorscheme.techbase',
  tokyonight = require 'slivers.colorscheme.tokyonight',
  vague = require 'slivers.colorscheme.vague',
  vscode = require 'slivers.colorscheme.vscode',
  xcode = require 'slivers.colorscheme.xcode',
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
