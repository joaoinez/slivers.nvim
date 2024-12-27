---@type LazySpec
return {
  'folke/tokyonight.nvim',
  enabled = true,
  -- priority = 1000,
  lazy = true,
  opts = {
    transparent = vim.g.transparent_bg,
  },
  init = function() ColorSliver.apply() end,
}
