---@type LazySpec
return {
  'Shatur/neovim-ayu',
  enabled = false,
  priority = 1000,
  lazy = Slivers.colorscheme.get_config(ColorSliver.colorschemes, vim.g.colors_name).name ~= 'ayu',
  config = function()
    require('ayu').setup {
      mirage = false, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
      terminal = false, -- Set to `false` to let terminal manage its own colors.
      overrides = vim.g.transparent_bg and {
        Normal = { bg = 'None' },
        NormalFloat = { bg = 'none' },
        ColorColumn = { bg = 'None' },
        SignColumn = { bg = 'None' },
        Folded = { bg = 'None' },
        FoldColumn = { bg = 'None' },
        CursorLine = { bg = 'None' },
        CursorColumn = { bg = 'None' },
        VertSplit = { bg = 'None' },
      } or {},
    }
  end,
}
