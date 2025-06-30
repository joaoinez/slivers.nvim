return {
  {
    'zeioth/compiler.nvim',
    enabled = false,
    cond = not vim.g.vscode,
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    cmd = {
      'CompilerOpen',
      'CompilerToggleResults',
      'CompilerRedo',
      'CompilerStop',
    },
    keys = {
      { '<leader>r', '<cmd>CompilerOpen<cr>', desc = 'Run Code' },
      { '<leader>R', '<cmd>CompilerStop<cr>' .. '<cmd>CompilerRedo<cr>', desc = 'Rerun Code' },
      { '<leader>tc', '<cmd>CompilerToggleResults<cr>', desc = 'Compiler' },
    },
    opts = {},
  },
  {
    'stevearc/overseer.nvim',
    cmd = {
      'OverseerOpen',
      'OverseerClose',
      'OverseerToggle',
      'OverseerSaveBundle',
      'OverseerLoadBundle',
      'OverseerDeleteBundle',
      'OverseerRunCmd',
      'OverseerRun',
      'OverseerInfo',
      'OverseerBuild',
      'OverseerQuickAction',
      'OverseerTaskAction',
      'OverseerClearCache',
    },
    opts = {
      task_list = {
        direction = 'bottom',
        min_height = 25,
        max_height = 25,
        default_detail = 1,
      },
    },
  },
}
