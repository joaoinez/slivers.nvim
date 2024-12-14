---@diagnostic disable: missing-fields

return {
  'neovim/nvim-lspconfig',
  enabled = true,
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePost' },
  config = function()
    local lang = require 'config.lang'
    local servers = lang.get_servers()
    local autocmd = SliverUtils.autocmds.autocmd
    local augroup = SliverUtils.autocmds.augroup

    autocmd('LspAttach', {
      group = augroup 'lsp_attach',
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        require('plugins.lspconfig.keymaps').apply_user_lsp_mappings(client, event.buf)
        require('plugins.lspconfig.autocmds').apply_user_lsp_autocmds(client, event.buf)
      end,
    })

    local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
    local diagnostic_signs = {}

    for type, icon in pairs(signs) do
      diagnostic_signs[vim.diagnostic.severity[type]] = icon
    end

    vim.diagnostic.config {
      signs = { text = diagnostic_signs },
      virtual_text = {
        spacing = 4,
        source = 'if_many',
        prefix = '●',
      },
    }

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    if SliverUtils.lazy.is_available 'cmp_nvim_lsp' then
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
    end

    local ensure_installed = vim.tbl_keys(lang.get_servers() or {})
    vim.list_extend(ensure_installed, lang.get_formatters() or {})
    vim.list_extend(ensure_installed, lang.get_linters() or {})
    vim.list_extend(ensure_installed, lang.get_debuggers() or {})

    require('mason').setup()
    require('mason-tool-installer').setup {
      run_on_start = false,
      ensure_installed = ensure_installed,
    }
    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
