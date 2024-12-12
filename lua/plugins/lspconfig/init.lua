---@diagnostic disable: missing-fields

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePost' },
  config = function()
    local servers = require('config.lang').get_servers()
    local utils = require 'utils'
    local autocmd = utils.autocmd
    local augroup = utils.augroup

    local vue_plugin = {
      name = '@vue/typescript-plugin',
      location = utils.get_pkg_path('vue-language-server', '/node_modules/@vue/language-server'),
      languages = { 'vue' },
      configNamespace = 'typescript',
      enableForWorkspaceTypeScriptVersions = true,
    }

    table.insert(servers.vtsls.settings.vtsls.tsserver.globalPlugins, vue_plugin)

    autocmd('LspAttach', {
      group = augroup 'lsp_attach',
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        require('plugins.lspconfig.keymaps').apply_user_lsp_mappings(client, event.buf)
        require('plugins.lspconfig.autocmds').apply_user_lsp_autocmds(client, event.buf)
      end,
    })

    if vim.g.have_nerd_font then
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
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

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
