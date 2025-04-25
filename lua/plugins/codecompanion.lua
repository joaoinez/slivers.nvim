---@type LazySpec
return {
  'olimorris/codecompanion.nvim',
  enabled = false,
  cond = not vim.g.vscode,
  event = 'VeryLazy',
  keys = {
    {
      '<leader>aa',
      '<cmd>CodeCompanionChat Toggle<cr>',
      desc = 'Code Companion',
      mode = { 'n', 'v' },
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
              -- Location to the slash command in CodeCompanion
              callback = 'strategies.chat.slash_commands.file',
              description = 'Select a file using Snacks',
              opts = {
                provider = 'snacks', -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks"
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
            ---The header name for the LLM's messages
            ---@type string|fun(adapter: CodeCompanion.Adapter): string
            llm = function(adapter) return 'CodeCompanion (' .. adapter.formatted_name .. ')' end,

            ---The header name for your messages
            ---@type string
            user = 'Me',
          },
        },
        inline = {
          adapter = provider,
        },
      },
      adapters = {
        opts = {
          show_defaults = false,
        },
        ['deepseek-v3'] = function()
          return require('codecompanion.adapters').extend('openai_compatible', {
            env = {
              url = 'https://openrouter.ai/api',
              api_key = 'OPENROUTER_API_KEY',
              chat_url = '/v1/chat/completions',
            },
            schema = {
              model = {
                default = 'deepseek/deepseek-chat-v3-0324',
              },
            },
          })
        end,
        ['deepseek-r1'] = function()
          return require('codecompanion.adapters').extend('openai_compatible', {
            env = {
              url = 'https://openrouter.ai/api',
              api_key = 'OPENROUTER_API_KEY',
              chat_url = '/v1/chat/completions',
            },
            schema = {
              model = {
                default = 'deepseek/deepseek-r1',
              },
            },
          })
        end,
      },
      display = {
        chat = {
          window = {
            width = 0.4,
          },
          show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
          start_in_insert_mode = true, -- Open the chat buffer in insert mode?
        },
      },
    }
  end,
}
