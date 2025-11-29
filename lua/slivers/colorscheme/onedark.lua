local M = {
  name = 'onedark',
  hl_groups = function()
    Slivers.colorscheme.fix_transparent_bg()

    return require 'slivers.colorscheme._fallback'
  end,
  globals = function()
    local trouble_lualine = vim.g.trouble_lualine
    if vim.g.transparent_bg then trouble_lualine = false end

    return {
      trouble_lualine = trouble_lualine,
    }
  end,
}

return M
