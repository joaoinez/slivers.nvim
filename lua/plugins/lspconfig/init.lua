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
        },
      },
    },
    'mason-org/mason-lspconfig.nvim',
    { 'WhoIsSethDaniel/mason-tool-installer.nvim', build = ':MasonToolsUpdate' },
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
    require('mason-tool-installer').setup { ensure_installed = servers }
    require('mason-lspconfig').setup {
      ensure_installed = {},
      automatic_enable = true,
    }

    autocmd('LspAttach', {
      group = augroup 'lsp_attach',
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        require('plugins.lspconfig.keymaps').apply_user_lsp_mappings(client, event.buf)
        require('plugins.lspconfig.autocmds').apply_user_lsp_autocmds(client, event.buf)
      end,
    })

    require 'plugins.lspconfig.diagnostic'
  end,
}
