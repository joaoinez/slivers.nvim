---@type LazySpec
return {
  'folke/ts-comments.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  event = 'VeryLazy',
  opts = {},
}
