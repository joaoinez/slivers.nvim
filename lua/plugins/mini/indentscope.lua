return {
  'echasnovski/mini.indentscope',
  enabled = true,
  version = false, -- wait till new 0.7.0 release to put it back on semver
  event = 'User LazyFile',
  opts = function()
    return {
      draw = {
        delay = 0,
        animation = require('mini.indentscope').gen_animation.none(),
      },
      symbol = '│',
      options = { try_as_border = true },
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
        '*oil*',
        '*dap*',
      },
      callback = function() vim.b.miniindentscope_disable = true end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'SnacksDashboardOpened',
      callback = function(data) vim.b[data.buf].miniindentscope_disable = true end,
    })
  end,
}
