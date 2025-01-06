local M = {
  name = 'tokyonight',
  variants = {
    'tokyonight-night',
    'tokyonight-storm',
    'tokyonight-day',
    'tokyonight-moon',
  },
  hl_groups = function()
    local palette = require('tokyonight.colors').setup()

    return {
      Harpoon = { fg = palette.cyan },
      Macro = { fg = palette.purple },
      Lsp = { fg = palette.magenta },
      Lazy = { fg = palette.orange },
      Break = { fg = palette.red },
      Stop = { fg = palette.yellow },
    }
  end,
}

return M
