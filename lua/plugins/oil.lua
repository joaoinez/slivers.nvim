return {
  'stevearc/oil.nvim',
  cmd = { 'Oil' },
  keys = {
    {
      '<leader>fe',
      '<cmd>Oil<cr>',
      desc = 'File Explorer (oil)',
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
