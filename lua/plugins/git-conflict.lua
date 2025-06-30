---@type LazySpec
return {
  'akinsho/git-conflict.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  version = '*',
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePost' },
  ---@type GitConflictUserConfig
  opts = {
    default_mappings = true,
    default_commands = true,
    disable_diagnostics = true,
    list_opener = 'copen',
    highlights = {
      incoming = 'DiffAdd',
      current = 'DiffText',
    },
    debug = false,
  },
  ---@param opts GitConflictUserConfig
  config = function(opts)
    require('git-conflict').setup(opts)

    Slivers.autocmds.autocmd('User', {
      pattern = 'GitConflictDetected',
      callback = function() vim.notify('Conflict detected in ' .. vim.fn.expand '%') end,
    })
  end,
}
