return {
  'williamboman/mason.nvim',
  cmd = 'Mason',
  keys = { { '<leader>,m', '<cmd>Mason<cr>', desc = 'Mason' } },
  build = ':MasonUpdate',
  dependencies = {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    local servers = require('config.lsp').servers
    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua',
    })

    require('mason-tool-installer').setup {
      ensure_installed = ensure_installed,
    }
  end,
}
