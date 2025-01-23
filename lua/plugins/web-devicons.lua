---@type LazySpec
return {
  'nvim-tree/nvim-web-devicons',
  enabled = true,
  cond = not vim.g.vscode,
  lazy = true,
}
