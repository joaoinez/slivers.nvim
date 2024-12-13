return {
  'stevearc/oil.nvim',
  enabled = false,
  cmd = { 'Oil' },
  keys = {
    {
      '<leader>fe',
      '<cmd>Oil<cr>',
      desc = 'File Explorer',
    },
  },
  opts = {
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ['q'] = { 'actions.close', mode = 'n' },
    },
  },
}
