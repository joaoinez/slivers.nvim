---@type LazySpec
return {
  'nvzone/minty',
  enabled = true,
  cond = not vim.g.vscode,
  cmd = { 'Shades', 'Huefy' },
  keys = {
    {
      '<leader>kcs',
      '<cmd>Shades<cr>',
      desc = 'Shades',
    },
    {
      '<leader>kch',
      '<cmd>Huefy<cr>',
      desc = 'Hues',
    },
  },
}
