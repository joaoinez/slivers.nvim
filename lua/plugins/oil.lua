---@type LazySpec
return {
  'stevearc/oil.nvim',
  enabled = true,
  cmd = { 'Oil' },
  opts = {
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ['q'] = { 'actions.close', mode = 'n' },
    },
  },
}
