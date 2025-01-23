---@type LazySpec
return {
  'b0o/SchemaStore.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  version = false,
  lazy = true,
}
