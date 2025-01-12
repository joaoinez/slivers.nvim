-- [[ Example Colorscheme ]]

---@type LazySpec
return true and {}
  or {
    'example/colorscheme.nvim',
    enabled = true,
    priority = 1000,
    lazy = Slivers.colorscheme.get_config(ColorSliver.colorschemes, vim.g.colors_name).name ~= 'example',
    opts = {
      transparent = vim.g.transparent_bg,
    },
  }
