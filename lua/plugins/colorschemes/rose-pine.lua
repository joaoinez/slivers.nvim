---@type LazySpec
return {
  'rose-pine/neovim',
  enabled = true,
  name = 'rose-pine',
  -- priority = 1000,
  lazy = true,
  opts = {
    styles = {
      transparency = vim.g.transparent_bg,
    },
  },
  init = function() ColorSliver.apply() end,
}
