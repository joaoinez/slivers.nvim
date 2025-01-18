---@type LazySpec
return {
  'scottmckendry/cyberdream.nvim',
  enabled = true,
  priority = 1000,
  lazy = Slivers.colorscheme.get_config(ColorSliver.colorschemes, vim.g.colors_name).name ~= 'cyberdream',
  opts = {
    transparent = vim.g.transparent_bg,
    theme = {
      variant = 'auto',
    },
  },
}
