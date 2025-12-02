---@type LazySpec
return {
  'srcery-colors/srcery-vim',
  enabled = true,
  priority = 1000,
  lazy = Slivers.colorscheme.get_config(ColorSliver.colorschemes, vim.g.colors_name).name ~= 'srcery',
}
