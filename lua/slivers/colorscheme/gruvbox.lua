local M = {
  name = 'gruvbox',
  globals = function()
    return {
      lualine_borders = false,
      trouble_lualine = not vim.g.transparent_bg,
    }
  end,
}

return M
