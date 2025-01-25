---@type LazySpec
return {
  'akinsho/git-conflict.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  version = '*',
  -- TODO: Test this
  event = { 'BufReadPre', 'BufNewFile' },
  -- event = { 'BufReadPost', 'BufNewFile', 'BufWritePost' },
  opts = {},
}
