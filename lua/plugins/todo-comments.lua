---@type LazySpec
return {
  'folke/todo-comments.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePost' },
  cmd = { 'TodoTrouble' },
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
    {
      '<leader>qt',
      ---@diagnostic disable-next-line: undefined-field
      function() Snacks.picker.todo_comments() end,
      desc = 'Todos (snacks)',
    },
    { '<leader>qT', '<cmd>Trouble todo toggle<cr>', desc = 'Todos (trouble)' },
  },
  opts = { signs = false },
}
