---@type LazySpec
return {
  'navarasu/onedark.nvim',
  enabled = true,
  -- priority = 1000,
  lazy = true,
  opts = {
    -- INFO: 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    style = 'deep',
    transparent = vim.g.transparent_bg,
    lualine = {
      transparent = vim.g.transparent_bg,
    },
  },
}
