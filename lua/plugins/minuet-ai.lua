---@type LazySpec
return {
  'milanglacier/minuet-ai.nvim',
  enabled = false,
  event = 'VeryLazy',
  opts = {
    provider = 'openai_fim_compatible',
    provider_options = {
      openai_fim_compatible = {
        model = 'qwen2.5-coder:1.5b-base',
        end_point = 'http://127.0.0.1:11434/v1/completions',
        name = 'Ollama',
        stream = true,
        api_key = 'OLLAMA_API_KEY',
        optional = {
          stop = nil,
          max_tokens = nil,
        },
      },
    },
    throttle = 500, -- only send the request every x milliseconds, use 0 to disable throttle.
    debounce = 0, -- debounce the request in x milliseconds, set to 0 to disable debounce
    cmp = {
      enable_auto_complete = false,
    },
    blink = {
      enable_auto_complete = false,
    },
    virtualtext = {
      auto_trigger_ft = { '*' },
      keymap = {
        accept = '<M-y>',
        accept_line = '<M-Y>',
        prev = '<M-p>',
        next = '<M-n>',
        dismiss = '<M-e>',
      },
    },
    notify = false,
  },
}
