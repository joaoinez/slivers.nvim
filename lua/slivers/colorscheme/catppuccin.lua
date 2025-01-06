local M = {
  name = 'catppuccin',
  variants = {
    'catppuccin-mocha',
    'catppuccin-macchiato',
    'catppuccin-latte',
    'catppuccin-frappe',
  },
  hl_groups = function()
    local palette = require('catppuccin.palettes').get_palette(
      vim.g.colorscheme == 'catppuccin' and 'mocha' or vim.g.colorscheme:gsub('catppuccin%-', '')
    )

    return {
      Harpoon = { fg = palette.sky },
      Macro = { fg = palette.lavender },
      Lsp = { fg = palette.pink },
      Lazy = { fg = palette.peach },
      Break = { fg = palette.red },
      Stop = { fg = palette.yellow },
    }
  end,
}

return M
