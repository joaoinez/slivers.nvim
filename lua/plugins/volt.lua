---@type LazySpec
return {
  'nvzone/volt',
  enabled = true,
  cond = not vim.g.vscode,
  lazy = true,
}
