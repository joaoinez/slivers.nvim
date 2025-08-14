---@type LazySpec
return {
  'mcauley-penney/techbase.nvim',
  enabled = true,
  priority = 1000,
  lazy = Slivers.colorscheme.get_config(ColorSliver.colorschemes, vim.g.colors_name).name ~= 'techbase',
  opts = {
    transparent = vim.g.transparent_bg,
    plugin_support = {
      lualine = true,
    },
  },
}
