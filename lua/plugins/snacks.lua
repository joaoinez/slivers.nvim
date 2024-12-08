---@diagnostic disable: undefined-global

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = [[
           ▄ ▄                   
       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     
       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     
    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     
  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  
  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄
▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █
█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █
    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    
]],
      },
    },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit' },
  },
}
