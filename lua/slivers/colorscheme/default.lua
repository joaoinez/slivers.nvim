local M = {
  hl_groups = function()
    if vim.g.transparent_bg then
      vim.cmd 'highlight Normal guibg=NONE ctermbg=NONE'
      vim.cmd 'highlight NormalFloat guibg=NONE'
      vim.cmd 'highlight FloatBorder guibg=NONE'
      vim.cmd 'highlight FloatTitle guibg=NONE'
    end

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
