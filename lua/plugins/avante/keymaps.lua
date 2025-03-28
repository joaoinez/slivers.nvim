local M = {}

M.load_keymaps = function()
  local templates = require 'plugins.avante.templates'
  local prefill_edit_window = templates.prefill_edit_window

  Slivers.lazy.on_load('which-key.nvim', function()
    vim.schedule(function()
      require('which-key').add({
        {
          '<leader>aa',
          desc = 'Ask AI',
        },
        {
          '<leader>aa',
          desc = 'Ask',
          mode = 'v',
        },
        {
          '<leader>ae',
          desc = 'Edit',
          mode = 'v',
        },
        {
          '<leader>af',
          desc = 'Add File to Chat',
        },
        {
          '<leader>ad',
          hidden = true,
        },
        {
          '<leader>aF',
          desc = 'Focus Window',
        },
        {
          '<leader>ah',
          hidden = true,
        },
        {
          '<leader>ar',
          desc = 'Refresh Chat',
        },
        {
          '<leader>aR',
          desc = 'Repo Map',
        },
        {
          '<leader>as',
          hidden = true,
        },
        {
          '<leader>aS',
          desc = 'Stop Response',
        },
        {
          '<leader>a?',
          desc = 'Select Model',
        },
        {
          '<leader>ta',
          desc = 'AI Sidebar',
        },
        {
          mode = { 'n', 'v' },
          {
            '<leader>aK',
            function() require('avante.api').ask { question = templates.avante_keywords } end,
            desc = 'Keywords',
          },
          {
            '<leader>al',
            function() require('avante.api').ask { question = templates.avante_code_readability_analysis } end,
            desc = 'Code Readability Analysis',
          },
          {
            '<leader>ax',
            function() require('avante.api').ask { question = templates.avante_explain_code } end,
            desc = 'Explain Code',
          },
        },
        {
          mode = { 'v' },
          {
            '<leader>aC',
            function() prefill_edit_window(templates.avante_complete_code) end,
            desc = 'Complete Code',
          },
          {
            '<leader>aD',
            function() prefill_edit_window(templates.avante_add_docstring) end,
            desc = 'Docstring',
          },
          {
            '<leader>aT',
            function() prefill_edit_window(templates.avante_add_tests) end,
            desc = 'Add Tests',
          },
        },
      }, { notify = false })
    end)
  end)
end

return M
