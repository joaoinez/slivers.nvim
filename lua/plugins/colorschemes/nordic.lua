---@type LazySpec
return {
  'AlexvZyl/nordic.nvim',
  enabled = false,
  priority = 1000,
  lazy = Slivers.colorscheme.get_config(ColorSliver.colorschemes, vim.g.colors_name).name ~= 'nordic',
  opts = {
    transparent = {
      bg = vim.g.transparent_bg,
      float = vim.g.transparent_bg,
    },
  },
}
