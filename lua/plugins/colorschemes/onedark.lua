---@type LazySpec
return {
  'navarasu/onedark.nvim',
  enabled = false,
  priority = 1000,
  lazy = Slivers.colorscheme.get_config(ColorSliver.colorschemes, vim.g.colors_name).name ~= 'onedark',
  opts = {
    -- INFO: 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    style = 'darker',
    transparent = vim.g.transparent_bg,
    lualine = {
      transparent = vim.g.transparent_bg,
    },
  },
}
