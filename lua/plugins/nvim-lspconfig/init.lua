---@diagnostic disable: missing-fields

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    {
      'j-hui/fidget.nvim',
      opts = { notification = { window = { winblend = 0 } } },
    },
    'hrsh7th/cmp-nvim-lsp',
  },
  event = 'BufRead',
  -- TODO: See why this isn't working
  --
  -- event = 'User Lazyfile',
  config = function()
    local servers = require('config.lsp').servers
    local utils = require 'utils'
    local autocmd = utils.autocmd
    local augroup = utils.augroup

    autocmd('LspAttach', {
      group = augroup 'lsp_attach',
      callback = function(event)
        local maps = utils.get_mappings_template()
        local builtin = require 'telescope.builtin'

        maps.n['gd'] = {
          function() builtin.lsp_definitions() end,
          desc = 'Goto Definition',
        }
        maps.n['gr'] = {
          function() builtin.lsp_references() end,
          desc = 'Goto References',
        }
        maps.n['gI'] = {
          function() builtin.lsp_implementations() end,
          desc = 'Goto Implementation',
        }
        maps.n['<leader>D'] = {
          function() builtin.lsp_type_definitions() end,
          desc = 'Type Definition',
        }
        maps.n['<leader>ds'] = {
          function() builtin.lsp_document_symbols() end,
          desc = 'Document Symbols',
        }
        maps.n['<leader>ws'] = {
          function() builtin.lsp_dynamic_workspace_symbols() end,
          desc = 'Workspace Symbols',
        }
        maps.n['gD'] = {
          vim.lsp.buf.declaration,
          desc = 'Goto Declaration',
        }
        maps.n['<leader>rn'] = {
          vim.lsp.buf.rename,
          desc = 'Rename',
        }
        maps.n['<leader>ca'] = {
          vim.lsp.buf.code_action,
          desc = 'Code Action',
        }
        maps.x['<leader>ca'] = {
          vim.lsp.buf.code_action,
          desc = 'Code Action',
        }

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if
          client
          and client.supports_method(
            vim.lsp.protocol.Methods.textDocument_documentHighlight
          )
        then
          utils.add_autocmds_to_buffer('slivers_lsp_highlight', event.buf, {
            {
              events = { 'CursorHold', 'CursorHoldI' },
              callback = vim.lsp.buf.document_highlight,
            },
            {
              events = { 'CursorMoved', 'CursorMovedI' },
              callback = vim.lsp.buf.clear_references,
            },
          })

          autocmd('LspDetach', {
            group = augroup 'lsp_detach',
            callback = function(e)
              vim.lsp.buf.clear_references()
              utils.del_autocmds_from_buffer('slivers_lsp_highlight', e.buf)
            end,
          })
        end

        if
          client
          and client.supports_method(
            vim.lsp.protocol.Methods.textDocument_inlayHint
          )
        then
          maps.n['<leader>th'] = {
            function()
              vim.lsp.inlay_hint.enable(
                not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }
              )
            end,
            desc = 'Toggle Inlay Hints',
          }
        end

        utils.set_mappings(maps)
      end,
    })

    if vim.g.have_nerd_font then
      local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
      local diagnostic_signs = {}
      for type, icon in pairs(signs) do
        diagnostic_signs[vim.diagnostic.severity[type]] = icon
      end
      vim.diagnostic.config { signs = { text = diagnostic_signs } }
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend(
      'force',
      capabilities,
      require('cmp_nvim_lsp').default_capabilities()
    )

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend(
            'force',
            {},
            capabilities,
            server.capabilities or {}
          )
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
