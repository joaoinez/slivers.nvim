---@type LazySpec
return {
  'akinsho/git-conflict.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  version = '*',
  event = { 'BufReadPre', 'BufNewFile' },
  -- event = { 'BufReadPost', 'BufNewFile', 'BufWritePost' },
  opts = {},
}
