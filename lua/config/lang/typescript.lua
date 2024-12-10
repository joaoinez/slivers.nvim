local M = {}

M.highlighters = {
  'css',
  'javascript',
  'tsx',
  'typescript',
  'vue',
}

M.servers = {
  tailwindcss = {
    settings = {
      tailwindCSS = {
        includeLanguages = {
          elixir = 'html-eex',
          eelixir = 'html-eex',
          heex = 'html-eex',
        },
      },
    },
  },
  volar = {
    init_options = {
      vue = {
        hybridMode = true,
      },
    },
  },
  vtsls = {
    filetypes = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
      'vue',
    },
    settings = {
      complete_function_calls = true,
      vtsls = {
        enableMoveToFileCodeAction = true,
        autoUseWorkspaceTsdk = true,
        experimental = {
          maxInlayHintLength = 30,
          completion = {
            enableServerSideFuzzyMatch = true,
          },
        },
        tsserver = {
          globalPlugins = {},
        },
      },
      javascript = {
        updateImportsOnFileMove = { enabled = 'always' },
        suggest = {
          completeFunctionCalls = true,
        },
        inlayHints = {
          enumMemberValues = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          parameterNames = { enabled = 'literals' },
          parameterTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          variableTypes = { enabled = false },
        },
      },
      typescript = {
        updateImportsOnFileMove = { enabled = 'always' },
        suggest = {
          completeFunctionCalls = true,
        },
        inlayHints = {
          enumMemberValues = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          parameterNames = { enabled = 'literals' },
          parameterTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          variableTypes = { enabled = false },
        },
      },
    },
    on_attach = function()
      local utils = require 'utils'
      local maps = utils.get_mappings_template()

      maps.n['gD'] = {
        function()
          local params = vim.lsp.util.make_position_params()
          require('utils').execute {
            command = 'typescript.goToSourceDefinition',
            arguments = { params.textDocument.uri, params.position },
            open = true,
          }
        end,
        desc = 'Goto Source Definition (trouble)',
      }
      maps.n['gR'] = {
        function()
          require('utils').execute {
            command = 'typescript.findAllFileReferences',
            arguments = { vim.uri_from_bufnr(0) },
            open = true,
          }
        end,
        desc = 'File References (trouble)',
      }
      maps.n['<leader>co'] = {
        utils.action['source.organizeImports'],
        desc = 'Organize Imports',
      }
      maps.n['<leader>cm'] = {
        utils.action['source.addMissingImports.ts'],
        desc = 'Add missing imports',
      }
      maps.n['<leader>cu'] = {
        utils.action['source.removeUnused.ts'],
        desc = 'Remove unused imports',
      }
      maps.n['<leader>cF'] = {
        utils.action['source.fixAll.ts'],
        desc = 'Fix all diagnostics',
      }
      maps.n['<leader>cV'] = {
        function() utils.execute { command = 'typescript.selectTypeScriptVersion' } end,
        desc = 'Select TS workspace version',
      }

      utils.set_mappings(maps)
    end,
  },
}

M.formatters = {
  'prettierd',
}

M.formatters_by_ft = {
  javascript = { 'prettierd' },
  javascriptreact = { 'prettierd' },
  typescript = { 'prettierd' },
  typescriptreact = { 'prettierd' },
  vue = { 'prettierd' },
}

M.linters = {
  'eslint_d',
}

M.linters_by_ft = {
  javascript = { 'eslint_d' },
  javascriptreact = { 'eslint_d' },
  typescript = { 'eslint_d' },
  typescriptreact = { 'eslint_d' },
  vue = { 'eslint_d' },
}

return M
