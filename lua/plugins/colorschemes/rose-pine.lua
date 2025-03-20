---@type LazySpec
return {
  'rose-pine/neovim',
  enabled = false,
  name = 'rose-pine',
  priority = 1000,
  lazy = Slivers.colorscheme.get_config(ColorSliver.colorschemes, vim.g.colors_name).name ~= 'rose-pine',
  opts = {
    styles = {
      transparency = vim.g.transparent_bg,
    },
  },
}
