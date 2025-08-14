---@type LazySpec
return {
  'folke/tokyonight.nvim',
  enabled = true,
  priority = 1000,
  lazy = Slivers.colorscheme.get_config(ColorSliver.colorschemes, vim.g.colors_name).name ~= 'tokyonight',
  opts = {
    transparent = vim.g.transparent_bg,
    on_highlights = function(highlights, colors)
      if vim.g.transparent_bg then
        highlights.NormalFloat = { bg = 'none' }
        highlights.FloatBorder = { bg = 'none' }
        highlights.FloatTitle = { bg = 'none' }
      end

      highlights.WinSeparator = { fg = colors.border_highlight }
    end,
  },
}
