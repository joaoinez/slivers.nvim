---@type LazySpec
return {
  'yetone/avante.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  dependencies = {
    {
      'stevearc/dressing.nvim',
      opts = { input = { enabled = false }, select = { enabled = false } },
    },
  },
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
      provider = 'qwen_coder',
      auto_suggestions_provider = 'qwen_mini',
      behaviour = {
        auto_suggestions = false,
      },
      vendors = {
        qwen_coder = {
          __inherited_from = 'openai',
          api_key_name = '',
          endpoint = 'http://127.0.0.1:11434/v1',
          model = 'qwen2.5-coder:14b-ctx',
        },
        deepseek_r1 = {
          __inherited_from = 'openai',
          api_key_name = '',
          endpoint = 'http://127.0.0.1:11434/v1',
          model = 'deepseek-r1:7b-ctx',
        },
        qwen_mini = {
          __inherited_from = 'openai',
          api_key_name = '',
          endpoint = 'http://127.0.0.1:11434/v1',
          model = 'qwen2.5-coder:1.5b-base',
        },
      },
      dual_boost = {
        enabled = vim.g.ai_architect_mode,
        first_provider = 'deepseek_r1',
        second_provider = 'qwen_coder',
        prompt = 'Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]',
        timeout = 300000, -- Timeout in milliseconds
      },
      windows = {
        input = {
          prefix = ' ',
        },
      },
      mappings = {
        toggle = {
          default = '<leader>ta',
        },
      },
    }
  end,
  config = function(_, opts)
    require('avante').setup(opts)
    require('plugins.avante.keymaps').load_keymaps()
  end,
}
