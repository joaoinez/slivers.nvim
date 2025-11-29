local M = {
  hl_groups = function()
    Slivers.colorscheme.fix_transparent_bg()

    return require 'slivers.colorscheme._fallback'
  end,
  globals = function()
    local trouble_lualine = vim.g.trouble_lualine
    if vim.g.transparent_bg then trouble_lualine = false end

    return {
      lualine_borders = false,
      trouble_lualine = trouble_lualine,
    }
  end,
}

return M
