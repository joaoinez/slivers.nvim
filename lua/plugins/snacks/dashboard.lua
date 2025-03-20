local M = {
  enabled = true,
  preset = {
    keys = {
      { icon = ' ', key = 'f', desc = 'Find File', action = ':lua Snacks.picker.files { hidden = true }' },
      { icon = ' ', key = 't', desc = 'Find Text', action = ':lua Snacks.picker.grep()' },
      { icon = '󰙅 ', key = 'e', desc = 'Explore Files', action = ':Oil' },
      { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
      { icon = '', key = 'r', desc = 'README', action = ':e README.md' },
      { desc = '' },
      { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
      { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
      { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
    },
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
  formats = {
    header = { '%s', align = 'center', hl = 'SnacksDashboardFooter' },
  },
  sections = {
    { section = 'header' },
    { text = '', padding = 1 },
    { section = 'keys', gap = 2, padding = 1 },
    { text = '', padding = 2 },
    { text = [[
／l、
  (､ ｡ ７
  l  ~ヽ
      じしf_,)ノ
    ]], align = 'center' },
    { section = 'startup', align = 'center' },
  },
}

return M
