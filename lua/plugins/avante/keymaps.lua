local M = {}

M.mappings = {
  diff = {
    ours = 'co',
    theirs = 'ct',
    all_theirs = 'ca',
    both = 'cb',
    cursor = 'cc',
    next = ']x',
    prev = '[x',
  },
  suggestion = {
    accept = '<M-y>',
    next = '<M-]>',
    prev = '<M-[>',
    dismiss = '<M-e>',
  },
  jump = {
    next = ']]',
    prev = '[[',
  },
  submit = {
    normal = '<CR>',
    insert = '<C-s>',
  },
  ask = '<leader>aa',
  edit = '<leader>ae',
  refresh = '<leader>ar',
  focus = '<leader>af',
  clear = '<leader>az',
  toggle = {
    default = '<leader>ta',
    debug = '<leader>ad',
    hint = '<leader>ah',
    suggestion = '<leader>as',
    repomap = '<leader>aR',
  },
  sidebar = {
    apply_all = 'A',
    apply_cursor = 'a',
    switch_windows = '<Tab>',
    reverse_switch_windows = '<S-Tab>',
    remove_file = 'd',
    add_file = '@',
  },
  files = {
    add_current = '<leader>aF',
  },
}

function M.keys(_, keys)
  local opts = Slivers.lazy.opts 'avante.nvim'

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
    {
      '<leader>al',
      function() require('avante.api').ask { question = require('plugins.avante.templates').code_readability_analysis } end,
      desc = 'Code Readability Analysis (ask)',
      mode = { 'n', 'v' },
    },
    {
      '<leader>ao',
      function() require('avante.api').ask { question = require('plugins.avante.templates').optimize_code } end,
      desc = 'Optimize Code (ask)',
      mode = { 'n', 'v' },
    },
    {
      '<leader>ax',
      function() require('avante.api').ask { question = require('plugins.avante.templates').explain_code } end,
      desc = 'Explain Code (ask)',
      mode = { 'n', 'v' },
    },
    {
      '<leader>ac',
      function() require('avante.api').ask { question = require('plugins.avante.templates').complete_code } end,
      desc = 'Complete Code (ask)',
      mode = { 'n', 'v' },
    },
    {
      '<leader>ad',
      function() require('avante.api').ask { question = require('plugins.avante.templates').add_docstring } end,
      desc = 'Docstring (ask)',
      mode = { 'n', 'v' },
    },
    {
      '<leader>ab',
      function() require('avante.api').ask { question = require('plugins.avante.templates').fix_bugs } end,
      desc = 'Fix Bugs (ask)',
      mode = { 'n', 'v' },
    },
    {
      '<leader>au',
      function() require('avante.api').ask { question = require('plugins.avante.templates').add_tests } end,
      desc = 'Add Tests (ask)',
      mode = { 'n', 'v' },
    },
    {
      '<leader>aO',
      function()
        require('plugins.avante.templates').prefill_edit_window(require('plugins.avante.templates').optimize_code)
      end,
      desc = 'Optimize Code (edit)',
      mode = 'v',
    },
    {
      '<leader>aC',
      function()
        require('plugins.avante.templates').prefill_edit_window(require('plugins.avante.templates').complete_code)
      end,
      desc = 'Complete Code (edit)',
      mode = 'v',
    },
    {
      '<leader>aD',
      function()
        require('plugins.avante.templates').prefill_edit_window(require('plugins.avante.templates').add_docstring)
      end,
      desc = 'Docstring (edit)',
      mode = 'v',
    },
    {
      '<leader>aB',
      function() require('plugins.avante.templates').prefill_edit_window(require('plugins.avante.templates').fix_bugs) end,
      desc = 'Fix Bugs (edit)',
      mode = 'v',
    },
    {
      '<leader>aU',
      function() require('plugins.avante.templates').prefill_edit_window(require('plugins.avante.templates').add_tests) end,
      desc = 'Add Tests (edit)',
      mode = 'v',
    },
  }

  mappings = vim.tbl_filter(function(m) return m[1] and #m[1] > 0 end, mappings)

  return vim.list_extend(mappings, keys)
end

return M
