---@type LazySpec
return {
  'olimorris/codecompanion.nvim',
  enabled = vim.g.ai_chat == 'codecompanion',
  cond = not vim.g.vscode,
  event = 'VeryLazy',
  keys = {
    {
      '<leader>aa',
      '<cmd>CodeCompanionChat Toggle<cr>',
      desc = 'Code Companion',
      mode = 'n',
    },
    {
      '<leader>aa',
      '<cmd>CodeCompanionChat Add<cr>',
      desc = 'Add Selection',
      mode = 'v',
    },
  },
  opts = function()
    local model = vim.g.ai_model or ''
    local provider = model:gsub('%-dual', '')

    return {
      strategies = {
        chat = {
          adapter = provider,
          slash_commands = {
            ['file'] = {
              callback = 'strategies.chat.slash_commands.file',
              description = 'Select a file using Snacks',
              opts = {
                provider = 'snacks',
                contains_code = true,
              },
            },
          },
          keymaps = {
            close = {
              modes = { n = 'q', i = '<C-d>' },
            },
            stop = {
              modes = { n = '<C-c>', i = '<C-c>' },
            },
          },
          roles = {
            llm = function(adapter) return 'AIstherae (' .. adapter.formatted_name .. ')' end,
            user = 'joaoinez',
          },
        },
        inline = {
          adapter = provider,
        },
      },
      adapters = require('plugins.codecompanion.adapters').get_models(),
      display = {
        chat = {
          window = {
            width = 0.4,
          },
          show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
          start_in_insert_mode = true, -- Open the chat buffer in insert mode?
        },
      },
      extensions = {
        mcphub = {
          callback = 'mcphub.extensions.codecompanion',
          opts = {
            show_result_in_chat = true, -- Show the mcp tool result in the chat buffer
            make_vars = true, -- make chat #variables from MCP server resources
            make_slash_commands = true, -- make /slash_commands from MCP server prompts
          },
        },
      },
    }
  end,
  init = function() vim.cmd [[cab cc CodeCompanion]] end,
}
