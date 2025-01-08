return {
  'yetone/avante.nvim',
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
    provider = 'ollama',
    auto_suggestions_provider = 'qwen',
    -- behaviour = {
    --   auto_suggestions = false, -- INFO: Experimental stage
    -- },
    vendors = {
      ollama = {
        __inherited_from = 'openai',
        api_key_name = '',
        endpoint = 'http://127.0.0.1:11434/v1',
        model = 'llama3.1:8b',
      },
      qwen = {
        __inherited_from = 'openai',
        api_key_name = '',
        endpoint = 'http://127.0.0.1:11434/v1',
        model = 'qwen2.5-coder:1.5b-base',
      },
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
