local M = {
  _fallback = {
    hl_groups = function()
      return {
        Harpoon = { fg = vim.api.nvim_get_hl(0, { name = 'Comment' }).fg },
        Macro = { fg = vim.api.nvim_get_hl(0, { name = 'Statement' }).fg },
        Lsp = { fg = vim.api.nvim_get_hl(0, { name = 'String' }).fg },
        Lazy = { fg = vim.api.nvim_get_hl(0, { name = 'Identifier' }).fg },
        Break = { fg = vim.api.nvim_get_hl(0, { name = 'Error' }).fg },
        Stop = { fg = vim.api.nvim_get_hl(0, { name = 'WarningMsg' }).fg },
      }
    end,
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
  gruvbox = {
    name = 'gruvbox',
  },
}

return M
