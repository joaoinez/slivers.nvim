local M = {
  name = 'onedark',
  hl_groups = function()
    if vim.g.transparent_bg then
      vim.cmd 'highlight NormalFloat  guibg=NONE'
      vim.cmd 'highlight FloatBorder  guibg=NONE'
      vim.cmd 'highlight FloatTitle  guibg=NONE'
    end

    return require 'slivers.colorscheme._fallback'
  end,
  globals = function()
    return {
      trouble_lualine = not vim.g.transparent_bg,
    }
  end,
}

return M
