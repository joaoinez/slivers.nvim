return {
  'rcarriga/nvim-notify',
  event = 'VeryLazy',
  keys = {
    {
      '<leader>mh',
      function() require('telescope').extensions.notify.notify(require('telescope.themes').get_ivy()) end,
      desc = 'Message History (telescope)',
    },
  },
  opts = {
    background_colour = '#000000',
  },
}
