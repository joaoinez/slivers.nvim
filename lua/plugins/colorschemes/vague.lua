---@type LazySpec
return {
  'vague2k/vague.nvim',
  enabled = false,
  priority = 1000,
  lazy = Slivers.colorscheme.get_config(ColorSliver.colorschemes, vim.g.colors_name).name ~= 'vague',
  opts = {
    transparent = vim.g.transparent_bg,
  },
}
