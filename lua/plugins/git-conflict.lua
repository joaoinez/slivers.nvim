---@type LazySpec
return {
  'akinsho/git-conflict.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  version = '*',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    disable_diagnostics = true,
  },
  init = function()
    Slivers.autocmds.autocmd('User', {
      pattern = 'GitConflictDetected',
      callback = function() vim.notify('Conflict detected in ' .. vim.fn.expand '<afile>') end,
    })
  end,
}
