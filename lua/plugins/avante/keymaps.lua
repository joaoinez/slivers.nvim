local M = {}

function M.keys(_, keys)
  local opts =
    require('lazy.core.plugin').values(require('lazy.core.config').spec.plugins['avante.nvim'], 'opts', false)

  local mappings = {
    {
      opts.mappings.ask,
      function() require('avante.api').ask() end,
      desc = 'Ask AI',
      mode = { 'n', 'v' },
    },
    {
      opts.mappings.edit,
      function() require('avante.api').edit() end,
      desc = 'Edit Selection',
      mode = 'v',
    },
    {
      opts.mappings.toggle.debug,
      function() require('avante.api').toggle.debug() end,
      desc = 'Toggle Debug',
    },
    {
      opts.mappings.focus,
      function() require('avante.api').focus() end,
      desc = 'Focus',
    },
    {
      opts.mappings.toggle.hint,
      function() require('avante.api').toggle.hint() end,
      desc = 'Toggle Hints',
    },
    {
      opts.mappings.refresh,
      function() require('avante.api').refresh() end,
      desc = 'Refresh',
    },
    {
      opts.mappings.toggle.repomap,
      function() require('avante.repo_map').show() end,
      desc = 'Repo Map',
    },
    {
      opts.mappings.toggle.suggestion,
      ---@diagnostic disable-next-line: undefined-field
      function() require('avante.api').toggle.suggestion() end,
      desc = 'Toggle Suggestions',
    },
    {
      opts.mappings.clear,
      '<cmd>AvanteClear<cr>',
      desc = 'Clear Chat',
    },
    {
      opts.mappings.toggle.default,
      function() require('avante.api').toggle() end,
      desc = 'Toggle AI',
    },
  }

  mappings = vim.tbl_filter(function(m) return m[1] and #m[1] > 0 end, mappings)

  return vim.list_extend(mappings, keys)
end

return M
