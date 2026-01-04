---@type LazySpec
return {
  'folke/sidekick.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  event = 'VeryLazy',
  keys = {
    {
      '<m-.>',
      function() require('sidekick.cli').toggle { name = 'opencode' } end,
      desc = 'Sidekick Toggle',
      mode = { 'n', 't', 'i', 'x' },
      expr = true,
    },
    {
      '<leader>aa',
      function() require('sidekick.cli').send { name = 'opencode', msg = '{file}' } end,
      desc = 'Ask AI',
    },
    {
      '<leader>ad',
      function() require('sidekick.cli').close { name = 'opencode' } end,
      desc = 'Detach a CLI Session',
    },
    {
      '<leader>at',
      function() require('sidekick.cli').send { name = 'opencode', msg = '{this}' } end,
      mode = { 'x', 'n' },
      desc = 'Send This',
    },
    {
      '<leader>af',
      function() require('sidekick.cli').send { name = 'opencode', msg = '{file}' } end,
      desc = 'Send File',
    },
    {
      '<leader>as',
      function() require('sidekick.cli').send { name = 'opencode', msg = '{selection}' } end,
      mode = { 'x' },
      desc = 'Send Visual Selection',
    },
    {
      '<leader>ap',
      function() require('sidekick.cli').prompt { name = 'opencode' } end,
      mode = { 'n', 'x' },
      desc = 'Sidekick Select Prompt',
    },
  },
  opts = {
    nes = {
      enabled = false,
    },
    cli = {
      win = {
        layout = 'float',
      },
      mux = {
        backend = 'tmux',
        enabled = true,
      },
      prompts = {
        changes = 'Can you review my changes?',
        diagnostics = 'Can you help me fix the diagnostics in {file}?\n{diagnostics}',
        diagnostics_all = 'Can you help me fix these diagnostics?\n{diagnostics_all}',
        document = 'Add documentation to {function|line}',
        explain = 'Explain {this}',
        fix = 'Can you fix {this}?',
        optimize = 'How can {this} be optimized?',
        review = 'Can you review {file} for any issues or improvements?',
        tests = 'Can you write tests for {this}?',
        -- simple context prompts
        buffers = '{buffers}',
        file = '{file}',
        line = '{line}',
        position = '{position}',
        quickfix = '{quickfix}',
        selection = '{selection}',
        ['function'] = '{function}',
        class = '{class}',
      },
    },
  },
}
