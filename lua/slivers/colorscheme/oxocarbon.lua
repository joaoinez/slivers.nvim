local M = {
  name = 'oxocarbon',
  hl_groups = function()
    if vim.g.transparent_bg then
      vim.cmd 'highlight Normal guibg=NONE ctermbg=NONE'
      vim.cmd 'highlight NormalFloat guibg=NONE'
      vim.cmd 'highlight NormalNC guibg=NONE'
      vim.cmd 'highlight FloatBorder guibg=NONE'
      vim.cmd 'highlight FloatTitle guibg=NONE'
    end

    return require 'slivers.colorscheme._fallback'
  end,
}

return M
