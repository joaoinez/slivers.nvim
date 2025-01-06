---@type LazySpec
return {
  'ThePrimeagen/harpoon',
  enabled = true,
  branch = 'harpoon2',
  event = 'VeryLazy',
  keys = {
    {
      '<leader>h',
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
      desc = 'Harpoon Select 1',
    },
    {
      '<M-i>',
      function() require('harpoon'):list():select(2) end,
      desc = 'Harpoon Select 2',
    },
    {
      '<M-o>',
      function() require('harpoon'):list():select(3) end,
      desc = 'Harpoon Select 3',
    },
  },
  opts = {
    settings = {
      save_on_toggle = true,
    },
  },
}
