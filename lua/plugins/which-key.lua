return {
  'folke/which-key.nvim',
  enabled = true,
  event = 'VeryLazy',
  opts = {
    spec = {
      { '<leader>c', group = 'code', mode = { 'n', 'x' } },
      { '<leader>cW', icon = '' },
      { '<leader>d', group = 'debug', mode = { 'n', 'v' } },
      { '<leader>f', group = 'find' },
      { '<leader>m', group = 'messages', icon = '󰍡' },
      { '<leader>mh', icon = '󰍡' },
      { '<leader>g', group = 'git', mode = { 'n', 'v' } },
      { '<leader>K', icon = '' },
      { '<leader>N', icon = '󰎕' },
      { '<leader>q', group = 'quickfix/diagnostics' },
      { '<leader>t', group = 'toggle' },
      { '<leader>tr', icon = '' },
      { '<leader>,', group = 'settings', icon = '󰒓' },
      { '<leader>,m', group = 'mason', icon = '󱌢' },
      { '<leader>|', icon = '' },
      { '<leader>\\', icon = '' },
    },
  },
  keys = {
    {
      '<leader>?',
      function() require('which-key').show { global = false } end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
}
