return {
  'stevearc/oil.nvim',
  keys = {
    {
      "<leader>fe",
      '<cmd>Oil<cr>',
      desc = "File Explorer (Oil)",
    },
  },
  opts = {
    view_options = {
      show_hidden = true
    },
  },
}
