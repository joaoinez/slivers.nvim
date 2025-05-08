---@type LazySpec
return {
  'arzg/vim-colors-xcode',
  enabled = true,
  priority = 1000,
  lazy = Slivers.colorscheme.get_config(ColorSliver.colorschemes, vim.g.colors_name).name ~= 'xcode',
}
