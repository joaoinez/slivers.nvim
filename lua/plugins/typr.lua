---@type LazySpec
return {
  'nvzone/typr',
  enabled = true,
  cond = not vim.g.vscode,
  event = 'VeryLazy',
  cmd = { 'Typr', 'TyprStats' },
  keys = {
    {
      '<leader>kt',
      '<cmd>Typr<cr>',
      desc = 'Typr',
    },
    {
      '<leader>kS',
      '<cmd>Typr<cr>',
      desc = 'TyprStats',
    },
  },
  opts = {},
}
