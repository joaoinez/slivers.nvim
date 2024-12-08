return {
  'williamboman/mason.nvim',
  cmd = 'Mason',
  keys = { { '<leader>,m', '<cmd>Mason<cr>', desc = 'Mason' } },
  build = ':MasonUpdate',
  -- PERF: Change this
  lazy = false,
  dependencies = {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
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
