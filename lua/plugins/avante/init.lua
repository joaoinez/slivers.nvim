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
      provider = 'claude',
      cursor_applying_provider = 'groq_llama',
      auto_suggestions_provider = 'groq_qwen',
      behaviour = {
        auto_suggestions = false,
        enable_cursor_planning_mode = true,
      },
      dual_boost = {
        enabled = vim.g.ai_architect_mode,
        first_provider = 'deepseek_r1',
        second_provider = 'claude',
        timeout = 60000 * 5, -- Timeout in milliseconds
      },
      vendors = {
        ---@type AvanteSupportedProvider
        deepseek_r1 = {
          __inherited_from = 'openai',
          api_key_name = 'FIREWORKS_API_KEY',
          endpoint = 'https://api.fireworks.ai/inference/v1',
          model = 'accounts/fireworks/models/deepseek-r1',
          max_tokens = 8000,
        },
        ---@type AvanteSupportedProvider
        groq_qwen = {
          __inherited_from = 'openai',
          api_key_name = 'GROQ_API_KEY',
          endpoint = 'https://api.groq.com/openai/v1/',
          model = 'qwen-2.5-coder-32b',
          max_tokens = 8192,
        },
        ---@type AvanteSupportedProvider
        groq_llama = {
          __inherited_from = 'openai',
          api_key_name = 'GROQ_API_KEY',
          endpoint = 'https://api.groq.com/openai/v1/',
          model = 'llama-3.3-70b-versatile',
          max_tokens = 32768,
        },
        fastapply = require('plugins.avante.ollama').model 'hf.co/Kortix/FastApply-7B-v1.0_GGUF:latest',
        ollama_qwen = require('plugins.avante.ollama').model 'qwen2.5-coder:latest',
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
    }
  end,
  config = function(_, opts)
    require('avante').setup(opts)
    require('plugins.avante.keymaps').load_keymaps()
  end,
}
