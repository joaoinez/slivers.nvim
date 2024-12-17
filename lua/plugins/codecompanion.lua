return {
  'olimorris/codecompanion.nvim',
  enabled = true,
  event = 'VeryLazy',
  opts = {
    strategies = {
      chat = {
        adapter = 'qwen_coder',
      },
      inline = {
        adapter = 'qwen_coder_mini',
      },
    },
    adapters = {
      qwen_coder = function()
        return require('codecompanion.adapters').extend('ollama', {
          schema = {
            model = {
              default = 'qwen2.5-coder:latest',
            },
          },
        })
      end,
      qwen_coder_mini = function()
        return require('codecompanion.adapters').extend('ollama', {
          schema = {
            model = {
              default = 'qwen2.5-coder:1.5b',
            },
          },
        })
      end,
    },
  },
}
