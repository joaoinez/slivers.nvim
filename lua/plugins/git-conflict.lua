---@type LazySpec
return vim.g.dev and {}
  or {
    'joaoinez/git-conflict.nvim',
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
      debug = false,
    },
    ---@param opts GitConflictUserConfig
    config = function(opts)
      require('git-conflict').setup(opts)

      Slivers.autocmds.autocmd('User', {
        pattern = 'GitConflictDetected',
        callback = function()
          vim.notify('Conflict detected in ' .. vim.fn.expand '%', vim.log.levels.WARN)
          vim.diagnostic.enable(false)
        end,
      })

      Slivers.autocmds.autocmd('User', {
        pattern = 'GitConflictResolved',
        callback = function() vim.diagnostic.enable(true) end,
      })
    end,
  }
