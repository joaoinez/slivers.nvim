local M = {
  enabled = true,
  pane_gap = 8,
  preset = {
    keys = {
      { icon = ' ', key = 'f', desc = 'Find File', action = ':lua Snacks.picker.files { hidden = true }' },
      { icon = ' ', key = 't', desc = 'Find Text', action = ':lua Snacks.picker.grep()' },
      { icon = '󰙅 ', key = 'e', desc = 'Explore Files', action = ':Oil' },
      { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
      { icon = ' ', key = 'r', desc = 'Recent Files', action = ':lua Snacks.picker.recent()' },
      { icon = '', key = 'R', desc = 'README', action = ':e README.md' },
      { icon = ' ', key = 'p', desc = 'Projects', action = ':lua Snacks.picker.projects()' },
      {
        icon = ' ',
        key = 'c',
        desc = 'Config',
        action = ":lua Snacks.picker.files { cwd = vim.fn.stdpath 'config' }",
      },
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
    { title = 'Quick Actions', padding = 1, align = 'center' },
    { section = 'keys', gap = 2, padding = 1 },
    { pane = 2, text = '', padding = 4 },
    {
      pane = 2,
      section = 'terminal',
      enabled = function() return not vim.g.server end,
      cmd = 'gh contrib --style dot',
      height = 5,
      padding = 4,
      indent = 4,
    },
    { pane = 2, title = 'More Actions', padding = 1, align = 'center' },
    { pane = 2, icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
    { pane = 2, icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
    {
      pane = 2,
      icon = ' ',
      desc = 'Browse Repo (github)',
      padding = 1,
      key = 'B',
      action = function() Snacks.gitbrowse() end,
    },
    {
      pane = 2,
      icon = ' ',
      title = 'Git Status',
      section = 'terminal',
      enabled = function() return not vim.g.server and Snacks.git.get_root() ~= nil end,
      cmd = 'hub --no-pager diff --stat -B -M -C',
      key = 'g',
      action = function() Snacks.lazygit() end,
      height = 10,
      padding = 1,
      indent = 3,
    },
    {
      pane = 2,
      icon = '󰌌 ',
      desc = 'Typr',
      padding = 1,
      key = 'K',
      action = ':ene | Typr',
    },
    {
      pane = 2,
      icon = '󰌌 ',
      desc = 'Typr Stats',
      padding = 1,
      key = 'S',
      action = ':ene | TyprStats',
    },
    { pane = 2, section = 'startup' },
  },
}

return M
