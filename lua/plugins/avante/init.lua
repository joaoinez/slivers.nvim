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
  opts = {
    provider = 'deepseek_coder',
    auto_suggestions_provider = 'qwen',
    behaviour = {
      auto_suggestions = false,
    },
    vendors = {
      deepseek_coder = {
        __inherited_from = 'openai',
        api_key_name = '',
        endpoint = 'http://127.0.0.1:11434/v1',
        -- model = 'deepseek-coder-v2:16b',
        model = 'qwen2.5-coder:14b',
      },
      deepseek_r1 = {
        __inherited_from = 'openai',
        api_key_name = '',
        endpoint = 'http://127.0.0.1:11434/v1',
        model = 'deepseek-r1:14b',
      },
      qwen = {
        __inherited_from = 'openai',
        api_key_name = '',
        endpoint = 'http://127.0.0.1:11434/v1',
        model = 'qwen2.5-coder:1.5b-base',
      },
    },
    dual_boost = {
      enabled = false,
      first_provider = 'deepseek_r1',
      second_provider = 'deepseek_coder',
      prompt = 'Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]',
      timeout = 300000, -- Timeout in milliseconds
    },
    windows = {
      input = {
        prefix = ' ',
      },
    },
  },
  config = function(_, opts)
    require('avante').setup(opts)

    Slivers.lazy.on_load('which-key.nvim', function()
      vim.schedule(
        function()
          require('which-key').add({
            {
              '<leader>aa',
              desc = 'Ask AI',
            },
            {
              '<leader>aa',
              desc = 'Ask',
              mode = 'v',
            },
            {
              '<leader>ae',
              desc = 'Edit',
              mode = 'v',
            },
            {
              '<leader>ac',
              desc = 'Add File to Chat',
            },
            {
              '<leader>ad',
              desc = 'Toggle Debugging',
            },
            {
              '<leader>af',
              desc = 'Focus Window',
            },
            {
              '<leader>ah',
              desc = 'Toggle Hint',
            },
            {
              '<leader>ar',
              desc = 'Refresh',
            },
            {
              '<leader>aR',
              desc = 'Repo Map',
            },
            {
              '<leader>as',
              desc = 'Toggle Suggestion',
            },
            {
              '<leader>at',
              desc = 'Toggle Chat',
            },
          }, { notify = false })
        end
      )
    end)
  end,
}
