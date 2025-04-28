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

    -- TODO: make this a settings thing
    -- vim.api.nvim_set_hl(0, 'DiffAdd', { fg = 'none', bg = '#2e4b2e', bold = true })
    -- vim.api.nvim_set_hl(0, 'DiffDelete', { fg = 'none', bg = '#4c1e15', bold = true })
    -- vim.api.nvim_set_hl(0, 'DiffChange', { fg = 'none', bg = '#45565c', bold = true })
    -- vim.api.nvim_set_hl(0, 'DiffText', { fg = 'none', bg = '#996d74', bold = true })

    return require 'slivers.colorscheme._fallback'
  end,
  globals = function()
    vim.g.terminal_color_8 = require('poimandres.palette').blueGray2

    return {}
  end,
}

return M
