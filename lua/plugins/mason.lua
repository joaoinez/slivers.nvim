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
    'MasonToolsUpdate',
  },
  keys = {
    { '<leader>,mo', '<cmd>Mason<cr>', desc = 'Open Mason' },
    { '<leader>,mu', '<cmd>MasonToolsUpdate<cr>', desc = 'Mason Update Tools' },
  },
  build = ':MasonUpdate',
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
