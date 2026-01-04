---@type LazySpec
return {
  'neovim/nvim-lspconfig',
  enabled = true,
  cond = not (vim.g.vscode or vim.g.server),
  dependencies = {
    {
      'mason-org/mason.nvim',
      build = ':MasonUpdate',
      opts = {
        registries = {
          'github:mason-org/mason-registry',
          'github:Crashdummyy/mason-registry',
        },
      },
    },
    'mason-org/mason-lspconfig.nvim',
    { 'WhoIsSethDaniel/mason-tool-installer.nvim', build = ':MasonToolsUpdate' },
    {
      'seblyng/roslyn.nvim',
      ft = { 'cs', 'cshtml', 'razor' },
      config = true,
    },
  },
  event = { 'BufReadPre', 'BufNewFile', 'BufWritePost' },
  config = function()
    local autocmd = Slivers.autocmds.autocmd
    local augroup = Slivers.autocmds.augroup
    local servers = {}

    for filename, filetype in vim.fs.dir(vim.fn.stdpath 'config' .. '/lsp') do
      if filetype == 'file' then
        local server_name = filename:match '^(.-)%.lua$'
        if server_name and server_name ~= '' then table.insert(servers, server_name) end
      end
    end

    vim.list_extend(servers, LangSliver.get_formatters() or {})
    vim.list_extend(servers, LangSliver.get_linters() or {})
    vim.list_extend(servers, LangSliver.get_debuggers() or {})

    require('mason').setup()
    require('mason-tool-installer').setup {
      ensure_installed = servers,
      integrations = {
        ['mason-lspconfig'] = true,
        ['mason-null-ls'] = false,
        ['mason-nvim-dap'] = true,
      },
    }
    require('mason-lspconfig').setup {
      ensure_installed = {},
      automatic_enable = true,
      automatic_installation = false,
    }

    for _, lsp in ipairs(LangSliver.get_lsp_configs() or {}) do
      pcall(lsp)
    end

    autocmd('LspAttach', {
      group = augroup 'lsp_attach',
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        require('plugins.lspconfig.keymaps').apply_user_lsp_mappings(client, event.buf)
        require('plugins.lspconfig.autocmds').apply_user_lsp_autocmds(client, event.buf)

        if not client then return end

        if client.name == 'gdscript' then require('slivers.lang.godot').init_nvim_server(client) end
        if client.name == 'gopls' then require('slivers.lang.go').semantic_token_workaround(client) end
      end,
    })

    require 'plugins.lspconfig.diagnostic'
  end,
}
