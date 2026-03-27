local greeting = function()
  local datetime = tonumber(os.date ' %H ')

  -- Determine the appropriate greeting based on the hour
  local mesg
  local username = os.getenv 'USERNAME' or os.getenv 'USER' or 'User'
  if datetime >= 0 and datetime < 6 then
    mesg = 'Dreaming..󰒲 󰒲 '
  elseif datetime >= 6 and datetime < 12 then
    mesg = '🌅 Hi ' .. username .. ', Good Morning ☀️'
  elseif datetime >= 12 and datetime < 18 then
    mesg = '🌞 Hi ' .. username .. ', Good Afternoon ☕️'
  elseif datetime >= 18 and datetime < 21 then
    mesg = '🌆 Hi ' .. username .. ', Good Evening 🌙'
  else
    mesg = 'Hi ' .. username .. ", it's getting late, get some sleep 😴"
  end
  return mesg
end

local M = {
  enabled = true,
  preset = {
    keys = {
      { icon = ' ', key = 'f', desc = 'Find File', action = ':lua Snacks.picker.files { hidden = true }' },
      { icon = ' ', key = 'g', desc = 'Grep Text', action = ':lua Snacks.picker.grep()' },
      { icon = '󰙅 ', key = 'e', desc = 'Explore Files', action = ':Oil' },
      { icon = '󰊢 ', key = 'G', desc = 'Git Status', action = ':lua Snacks.picker.git_status()' },
      { icon = '', key = 'r', desc = 'README', action = ':e README.md' },
      { desc = '' },
      { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
      {
        icon = '󰊤 ',
        key = 'H',
        desc = 'GitHub Dash',

        action = function() Snacks.terminal('gh dash', { win = { width = 0, height = 0 } }) end,
      },
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
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]],
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
        [[
⡆⣐⢕⢕⢕⢕⢕⢕⢕⢕⠅⢗⢕⢕⢕⢕⢕⢕⢕⠕⠕⢕⢕⢕⢕⢕⢕⢕⢕⢕
⢐⢕⢕⢕⢕⢕⣕⢕⢕⠕⠁⢕⢕⢕⢕⢕⢕⢕⢕⠅⡄⢕⢕⢕⢕⢕⢕⢕⢕⢕
⢕⢕⢕⢕⢕⠅⢗⢕⠕⣠⠄⣗⢕⢕⠕⢕⢕⢕⠕⢠⣿⠐⢕⢕⢕⠑⢕⢕⠵⢕
⢕⢕⢕⢕⠁⢜⠕⢁⣴⣿⡇⢓⢕⢵⢐⢕⢕⠕⢁⣾⢿⣧⠑⢕⢕⠄⢑⢕⠅⢕
⢕⢕⠵⢁⠔⢁⣤⣤⣶⣶⣶⡐⣕⢽⠐⢕⠕⣡⣾⣶⣶⣶⣤⡁⢓⢕⠄⢑⢅⢑
⠍⣧⠄⣶⣾⣿⣿⣿⣿⣿⣿⣷⣔⢕⢄⢡⣾⣿⣿⣿⣿⣿⣿⣿⣦⡑⢕⢤⠱⢐
⢠⢕⠅⣾⣿⠋⢿⣿⣿⣿⠉⣿⣿⣷⣦⣶⣽⣿⣿⠈⣿⣿⣿⣿⠏⢹⣷⣷⡅⢐
⣔⢕⢥⢻⣿⡀⠈⠛⠛⠁⢠⣿⣿⣿⣿⣿⣿⣿⣿⡀⠈⠛⠛⠁⠄⣼⣿⣿⡇⢔
⢕⢕⢽⢸⢟⢟⢖⢖⢤⣶⡟⢻⣿⡿⠻⣿⣿⡟⢀⣿⣦⢤⢤⢔⢞⢿⢿⣿⠁⢕
⢕⢕⠅⣐⢕⢕⢕⢕⢕⣿⣿⡄⠛⢀⣦⠈⠛⢁⣼⣿⢗⢕⢕⢕⢕⢕⢕⡏⣘⢕
⢕⢕⠅⢓⣕⣕⣕⣕⣵⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣷⣕⢕⢕⢕⢕⡵⢀⢕⢕
⢑⢕⠃⡈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢃⢕⢕⢕
⣆⢕⠄⢱⣄⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢁⢕⢕⠕⢁
⣿⣦⡀⣿⣿⣷⣶⣬⣍⣛⣛⣛⡛⠿⠿⠿⠛⠛⢛⣛⣉⣭⣤⣂⢜⠕⢑⣡⣴⣿
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
    { text = greeting(), align = 'center' },
    { text = '', padding = 1 },
    { section = 'startup', align = 'center' },
  },
}

return M
