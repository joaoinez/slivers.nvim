---@diagnostic disable: missing-fields

---@type LazySpec
return {
  'yetone/avante.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  build = 'make',
  event = 'VeryLazy',
  keys = {
    {
      '<leader>az',
      '<cmd>AvanteClear<cr>',
      desc = 'Clear Chat',
    },
  },
  opts = function()
    return {
      provider = vim.g.ai_local and 'ollama-qwen' or vim.g.ai_reason and 'claude-sonnet-reasoning' or 'claude',
      cursor_applying_provider = not vim.g.ai_local and 'groq-llama' or 'ollama-fastapply',
      auto_suggestions_provider = nil,
      behaviour = {
        auto_suggestions = false,
        enable_cursor_planning_mode = true,
      },
      dual_boost = {
        enabled = vim.g.ai_architect and not (vim.g.ai_local or vim.g.ai_reason),
        first_provider = 'deepseek-r1',
        second_provider = 'o3-mini-high',
        timeout = 60000 * 5, -- Timeout in milliseconds
      },
      rag_service = {
        enabled = true,
      },
      ---@type {[string]: AvanteProvider}
      vendors = {
        ---@type AvanteSupportedProvider
        ['claude-sonnet-reasoning'] = {
          __inherited_from = 'claude',
          temperature = 1,
          timeout = 30000,
          max_tokens = 8000,
          thinking = {
            type = 'enabled',
            budget_tokens = 4000,
          },
        },
        ---@type AvanteSupportedProvider
        ['deepseek-r1'] = {
          __inherited_from = 'openai',
          api_key_name = 'FIREWORKS_API_KEY',
          endpoint = 'https://api.fireworks.ai/inference/v1',
          model = 'accounts/fireworks/models/deepseek-r1',
          max_tokens = 8000,
        },
        ['o3-mini-high'] = {
          endpoint = 'https://api.openai.com/v1',
          model = 'o3-mini',
          timeout = 30000,
          temperature = 0,
          max_tokens = 8000,
          reasoning_effort = 'high',
        },
        ---@type AvanteSupportedProvider
        ['groq-llama'] = {
          __inherited_from = 'openai',
          api_key_name = 'GROQ_API_KEY',
          endpoint = 'https://api.groq.com/openai/v1/',
          model = 'llama-3.3-70b-versatile',
          max_tokens = 32768,
        },
        ---@type AvanteSupportedProvider
        ['groq-qwen'] = {
          __inherited_from = 'openai',
          api_key_name = 'GROQ_API_KEY',
          endpoint = 'https://api.groq.com/openai/v1/',
          model = 'qwen-2.5-coder-32b',
          max_tokens = 8192,
        },
        ['ollama-qwen'] = require('plugins.avante.ollama').model 'qwen2.5-coder:latest',
        ['ollama-fastapply'] = require('plugins.avante.ollama').model 'hf.co/Kortix/FastApply-1.5B-v1.0_GGUF:latest',
      },
      mappings = {
        toggle = {
          default = '<leader>ta',
        },
      },
      windows = {
        input = {
          prefix = ' ',
        },
      },
      file_selector = {
        provider = 'snacks',
      },
    }
  end,
  config = function(_, opts)
    require('avante').setup(opts)
    require('plugins.avante.keymaps').load_keymaps()
  end,
}
