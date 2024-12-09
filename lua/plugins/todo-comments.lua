-- Highlight todo, notes, etc in comments
return {
  'folke/todo-comments.nvim',
  cmd = { 'TodoTrouble', 'TodoTelescope' },
  event = 'User LazyFile',
  opts = { signs = false },
  keys = {
    {
      ']t',
      function() require('todo-comments').jump_next() end,
      desc = 'Next Todo Comment (todo-comments)',
    },
    {
      '[t',
      function() require('todo-comments').jump_prev() end,
      desc = 'Previous Todo Comment (todo-comments)',
    },
    { '<leader>qt', '<cmd>Trouble todo toggle<cr>', desc = 'Todos (trouble)' },
    { '<leader>qT', '<cmd>TodoTelescope<cr>', desc = 'Todos (telescope)' },
  },
}
