---@type LazySpec
return {
  'akinsho/git-conflict.nvim',
  enabled = false,
  cond = not vim.g.vscode,
  version = '*',
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePost' },
  opts = {
    disable_diagnostics = true,
  },
  -- init = function()
  --   Slivers.autocmds.autocmd('User', {
  --     pattern = 'GitConflictDetected',
  --     callback = function() vim.notify('Conflict detected in ' .. vim.fn.expand '<afile>') end,
  --   })
  -- end,
}
