local M = {
  name = 'oxocarbon',
  hl_groups = function()
    Slivers.colorscheme.fix_transparent_bg()

    vim.cmd 'highlight LineNr guibg=NONE'

    return require 'slivers.colorscheme._fallback'
  end,
}

return M
