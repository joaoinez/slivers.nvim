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
        LspReferenceText = { bg = p.blue4, fg = p.white },
        LspReferenceRead = { bg = p.blue4, fg = p.white },
        LspReferenceWrite = { bg = p.blue4, fg = p.white },
        RenderMarkdownCode = { bg = p.background1 },
        RainbowDelimiterRed = { fg = p.pink1 },
        RainbowDelimiterYellow = { fg = p.yellow },
        RainbowDelimiterBlue = { fg = p.blue1 },
        RainbowDelimiterOrange = { fg = p.pink3 },
        RainbowDelimiterGreen = { fg = p.teal1 },
        RainbowDelimiterViolet = { fg = p.blueGray1 },
        RainbowDelimiterCyan = { fg = p.blue3 },
      },
    }
  end,
}
