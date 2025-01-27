---@type LazySpec
return {
  'milanglacier/minuet-ai.nvim',
  enabled = false,
  cond = not vim.g.vscode,
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePost' },
  opts = {
    provider = 'openai_fim_compatible',
    n_completions = 2,
    context_window = 1024,
    throttle = 0,
    debounce = 350,
    provider_options = {
      openai_fim_compatible = {
        model = 'qwen2.5-coder:1.5b-base',
        end_point = 'http://127.0.0.1:11434/v1/completions',
        name = 'Ollama',
        api_key = 'OLLAMA_API_KEY',
        optional = {
          max_tokens = 256,
          top_p = 0.9,
        },
      },
    },
    cmp = {
      enable_auto_complete = false,
    },
    blink = {
      enable_auto_complete = false,
    },
    virtualtext = {
      auto_trigger_ft = { '*' },
      auto_trigger_ignore_ft = { 'AvanteInput', 'minifiles', 'oil' },
      keymap = {
        accept = '<A-a>',
        accept_line = '<A-l>',
        next = '<A-n>',
        dismiss = '<M-e>',
      },
    },
  },
}
