local M = {
  enabled = true,
  pane_gap = 8,
  preset = {
    keys = {
      { icon = ' ', key = 'f', desc = 'Find File', action = ":lua require('snacks').dashboard.pick()" },
      {
        icon = ' ',
        key = 't',
        desc = 'Find Text',
        action = ":lua require('snacks').dashboard.pick('live_grep')",
      },
      { icon = '󰙅 ', key = 'e', desc = 'Explore Files', action = ':lua Slivers.actions.explore()' },
      {
        icon = ' ',
        key = 'T',
        desc = 'Todos',
        action = ":lua require('todo-comments.fzf').todo({ keywords = { 'TODO', 'FIX', 'FIXME' } })",
      },
      {
        icon = ' ',
        key = 'c',
        desc = 'Config',
        action = ":lua require('snacks').dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
      },
      { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
      { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
      { icon = '󱌢 ', key = 'm', desc = 'Mason', action = ':Mason' },
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
    { pane = 2, section = 'terminal', cmd = 'gh contrib --style dot', height = 5, padding = 4, indent = 4 },
    { pane = 2, title = 'More Actions', padding = 1, align = 'center' },
    { pane = 2, icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
    { pane = 2, icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
    {
      pane = 2,
      icon = ' ',
      desc = 'Browse Repo (github)',
      padding = 1,
      key = 'B',
      action = function() require('snacks').gitbrowse() end,
    },
    {
      pane = 2,
      icon = ' ',
      title = 'Git Status',
      section = 'terminal',
      enabled = function() return require('snacks').git.get_root() ~= nil end,
      cmd = 'hub --no-pager diff --stat -B -M -C',
      key = 'g',
      action = function() require('snacks').lazygit() end,
      height = 10,
      padding = 1,
      indent = 3,
    },
    { pane = 2, section = 'startup' },
  },
}

return M
