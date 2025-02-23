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
      Macro = { fg = palette.purple },
      Lsp = { fg = palette.magenta },
      Lazy = { fg = palette.orange },
      Break = { fg = palette.red },
      Stop = { fg = palette.yellow },
    }
  end,
  globals = function()
    local lualine_borders = vim.g.lualine_borders
    local trouble_lualine = vim.g.trouble_lualine
    if vim.g.transparent_bg then
      lualine_borders = false
      trouble_lualine = false
    end

    return {
      lualine_borders = lualine_borders,
      trouble_lualine = trouble_lualine,
    }
  end,
}

return M
