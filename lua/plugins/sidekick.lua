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
        split = {
          width = 100,
        },
      },
    },
  },
  -- init = function()
  --   Slivers.autocmds.autocmd('InsertLeave', {
  --     pattern = '*',
  --     callback = function()
  --       if not require('luasnip').in_snippet() and vim.fn.mode() == 'n' then require('sidekick.nes').update() end
  --     end,
  --   })
  -- end,
}
