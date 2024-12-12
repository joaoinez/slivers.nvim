return {
  'echasnovski/mini.map',
  version = false,
  keys = {
    { '<leader>tm', function() require('mini.map').toggle() end, desc = 'Minimap' },
  },
  opts = function()
    local map = require 'mini.map'

    return {
      integrations = {
        map.gen_integration.diff(),
        map.gen_integration.diagnostic(),
        map.gen_integration.gitsigns(),
      },
      symbols = {
        encode = map.gen_encode_symbols.dot '4x2',
        scroll_line = '',
        scroll_view = '',
      },
      window = {
        focusable = false,
        show_integration_count = false,
        width = 25,
        winblend = 0,
        zindex = 25,
      },
    }
  end,
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
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
      },
      callback = function() vim.b.minimap_disable = true end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'SnacksDashboardOpened',
      callback = function(data) vim.b[data.buf].minimap_disable = true end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyFile',
      desc = 'Open mini.map on file open',
      callback = function() vim.schedule(require('mini.map').open) end,
    })
  end,
}
