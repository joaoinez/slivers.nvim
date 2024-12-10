return {
  'williamboman/mason.nvim',
  dependencies = {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  cmd = {
    'Mason',
    'MasonInstall',
    'MasonUninstall',
    'MasonUninstallAll',
    'MasonLog',
    'MasonUpdate',
  },
  keys = { { '<leader>,m', '<cmd>Mason<cr>', desc = 'Mason' } },
  build = ':MasonUpdate',
  lazy = false,
  config = function()
    local lang = require 'config.lang'

    require('mason').setup()

    local ensure_installed = vim.tbl_keys(lang.get_servers() or {})
    vim.list_extend(ensure_installed, lang.get_formatters())

    require('mason-tool-installer').setup {
      ensure_installed = ensure_installed,
    }
  end,
}
