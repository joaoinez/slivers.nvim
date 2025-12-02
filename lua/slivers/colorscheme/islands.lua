local M = {
  name = 'islands',
  hl_groups = function()
    Slivers.colorscheme.fix_transparent_bg()

    return require 'slivers.colorscheme._fallback'
  end,
}

return M
