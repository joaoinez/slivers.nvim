---@type LazySpec
return {
  'olivercederborg/poimandres.nvim',
  enabled = true,
  priority = 1000,
  lazy = Slivers.colorscheme.get_config(ColorSliver.colorschemes, vim.g.colors_name).name ~= 'poimandres',
  opts = {
    disable_background = vim.g.transparent_bg,
    disable_float_background = vim.g.transparent_bg,
  },
}
