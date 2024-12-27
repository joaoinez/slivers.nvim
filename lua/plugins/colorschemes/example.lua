-- [[ Example Colorscheme ]]

---@type LazySpec
return true and {}
  or {
    'example/colorscheme.nvim',
    enabled = true,
    -- priority = 1000,
    lazy = true,
    opts = {
      transparent = vim.g.transparent_bg,
    },
  }
