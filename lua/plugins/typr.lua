---@type LazySpec
return {
  'nvzone/typr',
  enabled = true,
  cond = not vim.g.vscode,
  event = 'VeryLazy',
  cmd = { 'Typr', 'TyprStats' },
  opts = {},
}
