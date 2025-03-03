local M = {
  name = 'poimandres',
  hl_groups = function()
    if vim.g.transparent_bg then
      vim.cmd 'highlight Normal guibg=NONE ctermbg=NONE'
      vim.cmd 'highlight NormalFloat guibg=NONE'
      vim.cmd 'highlight NormalNC guibg=NONE'
      vim.cmd 'highlight FloatBorder guibg=NONE'
      vim.cmd 'highlight FloatTitle guibg=NONE'
      vim.cmd 'highlight WinBar guibg=NONE'
      vim.cmd 'highlight WinBarNC guibg=NONE'
    end

    return require 'slivers.colorscheme._fallback'
  end,
  globals = function()
    vim.g.terminal_color_8 = require('poimandres.palette').blueGray2

    return {}
  end,
}

return M
