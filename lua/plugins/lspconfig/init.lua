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
      ft = { 'cs', 'razor' },
      dependencies = { { 'tris203/rzls.nvim', config = true } },
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

    vim.lsp.enable 'gdscript'

    local rzls_path = vim.fn.expand '$MASON/packages/rzls/libexec'
    local cmd = {
      'roslyn',
      '--stdio',
      '--logLevel=Information',
      '--extensionLogDirectory=' .. vim.fs.dirname(vim.lsp.log.get_filename()),
      '--razorSourceGenerator=' .. vim.fs.joinpath(rzls_path, 'Microsoft.CodeAnalysis.Razor.Compiler.dll'),
      '--razorDesignTimePath=' .. vim.fs.joinpath(rzls_path, 'Targets', 'Microsoft.NET.Sdk.Razor.DesignTime.targets'),
      '--extension',
      vim.fs.joinpath(rzls_path, 'RazorExtension', 'Microsoft.VisualStudioCode.RazorExtension.dll'),
    }

    vim.lsp.config('roslyn', {
      cmd = cmd,
      handlers = require 'rzls.roslyn_handlers',
      settings = {
        ['csharp|inlay_hints'] = {
          csharp_enable_inlay_hints_for_implicit_object_creation = true,
          csharp_enable_inlay_hints_for_implicit_variable_types = true,

          csharp_enable_inlay_hints_for_lambda_parameter_types = true,
          csharp_enable_inlay_hints_for_types = true,
          dotnet_enable_inlay_hints_for_indexer_parameters = true,
          dotnet_enable_inlay_hints_for_literal_parameters = true,
          dotnet_enable_inlay_hints_for_object_creation_parameters = true,
          dotnet_enable_inlay_hints_for_other_parameters = true,
          dotnet_enable_inlay_hints_for_parameters = true,
          dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
          dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
          dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
        },
        ['csharp|code_lens'] = {
          dotnet_enable_references_code_lens = true,
        },
      },
    })
    vim.lsp.enable 'roslyn'

    -- TODO: Move this to `lang` folder, and then call it here
    local base_on_attach = vim.lsp.config.eslint.on_attach
    vim.lsp.config('eslint', {
      on_attach = function(client, bufnr)
        if not base_on_attach then return end

        base_on_attach(client, bufnr)
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = bufnr,
          callback = function()
            local clients = vim.lsp.get_clients { bufnr = bufnr, name = 'eslint' }
            if
              clients
              and clients[1]
              and clients[1].server_capabilities
              and clients[1].server_capabilities.codeActionProvider
            then
              pcall(vim.cmd, 'LspEslintFixAll')
            end
          end,
        })
      end,
    })

    autocmd('LspAttach', {
      group = augroup 'lsp_attach',
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        require('plugins.lspconfig.keymaps').apply_user_lsp_mappings(client, event.buf)
        require('plugins.lspconfig.autocmds').apply_user_lsp_autocmds(client, event.buf)

        if client and client.name == 'gdscript' then require('plugins.lspconfig.godot').init_nvim_server(client) end
      end,
    })

    require 'plugins.lspconfig.diagnostic'
  end,
}
