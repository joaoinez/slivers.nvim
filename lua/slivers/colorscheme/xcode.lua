local M = {
  name = 'xcode',
  variants = {
    'xcodehc',
    'xcodewwdc',
    'xcodedark',
    'xcodedarkhc',
    'xcodelight',
    'xcodelighthc',
  },
  hl_groups = function()
    Slivers.colorscheme.fix_transparent_bg()

    return require 'slivers.colorscheme._fallback'
  end,
}

return M
