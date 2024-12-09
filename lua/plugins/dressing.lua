return {
  'stevearc/dressing.nvim',
  event = 'VeryLazy',
  opts = {
    select = {
      telescope = require('telescope.themes').get_cursor(),
    },
  },
}
