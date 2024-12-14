return {
  'Isrothy/neominimap.nvim',
  enabled = true,
  version = 'v3.*.*',
  event = 'VeryLazy',
  keys = {
    { '<leader>M', '<cmd>Neominimap toggleFocus<cr>', desc = 'Switch focus on minimap' },
  },
  init = function()
    vim.g.neominimap = {
      auto_enable = true,
      layout = 'float',
      float = {
        minimap_width = 25,
        max_minimap_height = nil,
        window_border = 'none',
      },
      exclude_filetypes = {
        'help',
        'bigfile',
        'Trouble',
        'alpha',
        'dashboard',
        'fzf',
        'help',
        'lazy',
        'mason',
        'neo-tree',
        'notify',
        'snacks_dashboard',
        'snacks_notif',
        'snacks_terminal',
        'snacks_win',
        'toggleterm',
        'trouble',
        'oil',
      },
      exclude_buftypes = {
        'nofile',
        'nowrite',
        'quickfix',
        'terminal',
        'prompt',
      },
    }
  end,
}
