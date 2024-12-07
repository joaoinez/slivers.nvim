return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  event = 'VeryLazy',
  keys = {
    {
      '<leader>a',
      function() require('harpoon'):list():add() end,
      desc = 'Harpoon File',
    },
    {
      '<leader>fh',
      function()
        local harpoon = require 'harpoon'
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = 'Harpoon Quick Menu',
    },
    {
      '<M-u>',
      function() require('harpoon'):list():select(1) end,
    },
    {
      '<M-i>',
      function() require('harpoon'):list():select(2) end,
    },
    {
      '<M-o>',
      function() require('harpoon'):list():select(3) end,
    },
    {
      '<M-p>',
      function() require('harpoon'):list():select(4) end,
    },
  },
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
    },
  },
}
