---@diagnostic disable: missing-fields

---@type LazySpec
return {
  'neovim/nvim-lspconfig',
  enabled = true,
  cond = not vim.g.vscode,
  dependencies = {
    { 'williamboman/mason.nvim', build = ':MasonUpdate', config = true },
    'williamboman/mason-lspconfig.nvim',
    { 'WhoIsSethDaniel/mason-tool-installer.nvim', build = ':MasonToolsUpdate' },
  },
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePost' },
  config = function()
    local autocmd = Slivers.autocmds.autocmd
    local augroup = Slivers.autocmds.augroup
    local servers = LangSliver.get_servers() or {}
    local icons = IconSliver.diagnostics

    autocmd('LspAttach', {
      group = augroup 'lsp_attach',
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        require('plugins.lspconfig.keymaps').apply_user_lsp_mappings(client, event.buf)
        require('plugins.lspconfig.autocmds').apply_user_lsp_autocmds(client, event.buf)
      end,
    })

    vim.diagnostic.config {
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = icons.error,
          [vim.diagnostic.severity.WARN] = icons.warn,
          [vim.diagnostic.severity.HINT] = icons.hint,
          [vim.diagnostic.severity.INFO] = icons.info,
        },
      },
      virtual_lines = false,
      virtual_text = {
        spacing = 4,
        source = 'if_many',
        prefix = icons.virtual,
      },
    }

    local ensure_installed = vim.tbl_keys(servers)
    vim.list_extend(ensure_installed, LangSliver.get_formatters() or {})
    vim.list_extend(ensure_installed, LangSliver.get_linters() or {})
    vim.list_extend(ensure_installed, LangSliver.get_debuggers() or {})

    local has_blink, blink = pcall(require, 'blink.cmp')

    require('mason').setup()
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }
    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}

          server.capabilities = vim.tbl_deep_extend(
            'force',
            {},
            vim.lsp.protocol.make_client_capabilities(),
            has_blink and blink.get_lsp_capabilities() or {},
            server.capabilities or {}
          )

          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
