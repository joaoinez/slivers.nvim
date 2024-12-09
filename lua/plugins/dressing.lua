return {
  'stevearc/dressing.nvim',
  event = 'VeryLazy',
  opts = {
    input = { default_prompt = ' ' },
    select = {
      telescope = require('telescope.themes').get_cursor(),
    },
  },
}
