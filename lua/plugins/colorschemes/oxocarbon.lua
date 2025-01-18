---@type LazySpec
return {
  'nyoom-engineering/oxocarbon.nvim',
  enabled = true,
  priority = 1000,
  lazy = Slivers.colorscheme.get_config(ColorSliver.colorschemes, vim.g.colors_name).name ~= 'oxocarbon',
}
