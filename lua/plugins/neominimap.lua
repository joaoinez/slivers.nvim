---@type LazySpec
return {
  'Isrothy/neominimap.nvim',
  enabled = true,
  version = 'v3.*.*',
  event = 'VeryLazy',
  keys = {
    { '<leader>M', '<cmd>Neominimap toggleFocus<cr>', desc = 'Minimap Focus' },
    { '<leader>tm', '<cmd>Neominimap toggle<cr>', desc = 'Minimap' },
  },
  init = function()
    vim.g.neominimap = {
      auto_enable = true,
      layout = 'float',
      float = {
        minimap_width = 25,
        max_minimap_height = nil,
        window_border = 'none',
        z_index = 2,
      },
      exclude_filetypes = {
        'help',
        'bigfile',
        'Trouble',
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
      fold = {
        enabled = false,
      },
    }
  end,
}
