---@type LazySpec
return {
  'projekt0n/github-nvim-theme',
  enabled = true,
  name = 'github-theme',
  priority = 1000,
  lazy = Slivers.colorscheme.get_config(ColorSliver.colorschemes, vim.g.colors_name).name ~= 'github',
  opts = {
    options = {
      transparent = vim.g.transparent_bg,
    },
  },
}
