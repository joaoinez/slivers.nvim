---@type LazySpec
return {
  'ellisonleao/gruvbox.nvim',
  enabled = true,
  priority = 1000,
  lazy = Slivers.colorscheme.get_config(ColorSliver.colorschemes, vim.g.colors_name).name ~= 'gruvbox',
  opts = {
    transparent_mode = vim.g.transparent_bg,
    contrast = 'hard',
  },
}
