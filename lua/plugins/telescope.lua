return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function() return vim.fn.executable 'make' == 1 end,
    },
  },
  keys = {
    {
      '<leader>ff',
      function() require('telescope.builtin').find_files() end,
      desc = 'Find Files (Root Dir)',
    },
    {
      '<leader>ft',
      function() require('telescope.builtin').live_grep() end,
      desc = 'Find Text (Grep)',
    },
    {
      '<leader><leader>',
      function() require('telescope.builtin').buffers() end,
      desc = 'Open Buffers',
    },
  },
  config = function()
    local telescope = require 'telescope'

    telescope.setup {}

    pcall(telescope.load_extension, 'fzf')
  end,
}
