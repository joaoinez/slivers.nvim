return {
  'yetone/avante.nvim',
  enabled = true,
  version = false,
  build = 'make',
  event = 'VeryLazy',
  keys = require('plugins.avante.keymaps').keys,
  opts = {
    behaviour = {
      auto_suggestions = true,
    },
    mappings = require('plugins.avante.keymaps').mappings,
    provider = 'ollama',
    auto_suggestions_provider = 'ollama',
    vendors = {
      ollama = {
        __inherited_from = 'openai',
        api_key_name = '',
        endpoint = 'http://127.0.0.1:11434/v1',
        model = 'qwen2.5-coder:latest',
      },
    },
  },
}
