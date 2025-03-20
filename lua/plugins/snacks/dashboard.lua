local M = {
  enabled = true,
  preset = {
    keys = {
      { icon = ' ', key = 'f', desc = 'Find File', action = ':lua Snacks.picker.files { hidden = true }' },
      { icon = ' ', key = 't', desc = 'Find Text', action = ':lua Snacks.picker.grep()' },
      { icon = '󰙅 ', key = 'e', desc = 'Explore Files', action = ':Oil' },
      { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
      { icon = '󰊢 ', key = 'g', desc = 'Git Status', action = ':lua Snacks.picker.git_status()' },
      { icon = '', key = 'r', desc = 'README', action = ':e README.md' },
      { desc = '' },
      { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
      { icon = '󰊤 ', key = 'B', desc = 'Browse Repo', action = function() Snacks.gitbrowse() end },
      { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
      { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
    },
    header = (function()
      local headers = {
        [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        [[
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
        [[
／l、
  (､ ｡ ７
  l  ~ヽ
      じしf_,)ノ
    ]],
      }
      math.randomseed(os.time())
      return headers[math.random(#headers)]
    end)(),
  },
  formats = {
    header = { '%s', align = 'center', hl = 'SnacksDashboardFooter' },
  },
  sections = {
    { section = 'header' },
    { text = '', padding = 1 },
    { section = 'keys', gap = 1, padding = 1 },
    { text = '', padding = 2 },
    { section = 'startup', align = 'center' },
  },
}

return M
