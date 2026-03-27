---@type LazySpec
return {
  'ellisonleao/gruvbox.nvim',
  enabled = true,
  priority = 1000,
  lazy = Slivers.colorscheme.get_config(ColorSliver.colorschemes, vim.g.colors_name).name ~= 'gruvbox',
  config = function()
    local colors = require('gruvbox').palette
    require('gruvbox').setup {
      transparent_mode = vim.g.transparent_bg,
      contrast = 'hard',
      overrides = {
        ['DiffText'] = { bg = colors.dark_red, fg = colors.light1 },
      },
    }
  end,
}
