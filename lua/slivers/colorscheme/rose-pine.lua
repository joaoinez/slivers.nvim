local M = {
  name = 'rose-pine',
  variants = {
    'rose-pine-main',
    'rose-pine-moon',
    'rose-pine-dawn',
  },
  hl_groups = function()
    local palette = require 'rose-pine.palette'

    return {
      Harpoon = { fg = palette.foam },
      Macro = { fg = palette.iris },
      Lsp = { fg = palette.rose },
      Lazy = { fg = palette.pine },
      Break = { fg = palette.love },
      Stop = { fg = palette.gold },
    }
  end,
}

return M
