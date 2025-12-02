---@type LazySpec
return {
  'joaoinez/islands.nvim',
  enabled = true,
  priority = 1000,
  lazy = Slivers.colorscheme.get_config(ColorSliver.colorschemes, vim.g.colors_name).name ~= 'islands',
  opts = {
    transparent_bg = vim.g.transparent_bg,
  },
}
