local M = {
  name = 'techbase',
  variants = {
    'escape_velocity',
    'hellbound',
  },
  hl_groups = function()
    Slivers.colorscheme.fix_transparent_bg()

    return require 'slivers.colorscheme._fallback'
  end,
}

return M
