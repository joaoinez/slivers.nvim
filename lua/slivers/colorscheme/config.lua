local M = {
  _fallback = {
    hl_groups = {
      Harpoon = { link = 'Comment' },
      Macro = { link = 'Statement' },
      Lsp = { link = 'String' },
      Lazy = { link = 'Identifier' },
      Break = { link = 'Error' },
      Stop = { link = 'WarningMsg' },
    },
  },
  catppuccin = {
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
  },
  tokyonight = {
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
  },
  ['rose-pine'] = {
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
  },
}

return M
