---@type LazySpec
return {
  'olivercederborg/poimandres.nvim',
  enabled = true,
  priority = 1000,
  lazy = Slivers.colorscheme.get_config(ColorSliver.colorschemes, vim.g.colors_name).name ~= 'poimandres',
  opts = function()
    local p = require 'poimandres.palette'

    return {
      disable_background = vim.g.transparent_bg,
      disable_float_background = vim.g.transparent_bg,
      highlight_groups = {
        LspReferenceText = { bg = p.blueGray3 },
        LspReferenceRead = { bg = p.blueGray3 },
        LspReferenceWrite = { bg = p.blueGray3 },

        -- NOTE: From https://github.com/olivercederborg/poimandres.nvim/pull/43/files
        FloatBorder = { fg = p.blueGray2 },
        MatchParen = { fg = p.blue2, bg = p.blueGray3 },
        ['@lsp.type.variable.typescriptreact'] = { fg = p.text },
        ['@lsp.type.parameter.typescriptreact'] = { fg = p.text },
        ['@lsp.type.property.typescriptreact'] = { fg = p.text },
        ['@comment.typescript'] = { fg = p.blueGray3 },
        ['@comment.documentation.typescript'] = { fg = p.blueGray3 },
        ['@variable.typescript'] = { fg = p.white },
        ['@variable.builtin.typescript'] = { fg = p.blue2 },
        ['@lsp.type.variable.typescript'] = { fg = p.text },
        ['@lsp.type.parameter.typescript'] = { fg = p.text },
        ['@lsp.type.property.typescript'] = { fg = p.text },
        ['@lsp.type.property.lua'] = { fg = p.text },

        WinSeparator = { fg = p.background3, bg = p.none },
        ColorColumn = { bg = p.background3 },

        RenderMarkdownCode = { bg = p.background1 },

        RainbowDelimiterRed = { fg = p.pink1 },
        RainbowDelimiterYellow = { fg = p.yellow },
        RainbowDelimiterBlue = { fg = p.blue1 },
        RainbowDelimiterOrange = { fg = p.pink3 },
        RainbowDelimiterGreen = { fg = p.teal1 },
        RainbowDelimiterViolet = { fg = p.blueGray1 },
        RainbowDelimiterCyan = { fg = p.blue3 },

        FlashLabel = { fg = p.white, bg = p.pink3 },
      },
    }
  end,
}
