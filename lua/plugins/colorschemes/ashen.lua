---@type LazySpec
return {
  'ficcdaf/ashen.nvim',
  enabled = false,
  lazy = Slivers.colorscheme.get_config(ColorSliver.colorschemes, vim.g.colors_name).name ~= 'ashen',
  priority = 1000,
  opts = {
    transparent = vim.g.transparent_bg,
  },
}
