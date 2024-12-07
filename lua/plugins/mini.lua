return {
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.icons').setup { enabled = vim.g.have_nerd_font } -- Nerd icons.
      require('mini.splitjoin').setup() -- Toggle split arrays and objects with `gS`.
    end,
  },
}
