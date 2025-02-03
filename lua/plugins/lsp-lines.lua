---@type LazySpec
return {
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePost' },
  opts = {},
}
