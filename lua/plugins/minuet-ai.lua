---@type LazySpec
return {
  'milanglacier/minuet-ai.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePost' },
  opts = {
    provider = 'openai_fim_compatible',
    n_completions = 1,
    context_window = 512,
    throttle = 0,
    debounce = 500,
    provider_options = {
      openai_fim_compatible = {
        model = 'qwen2.5-coder:1.5b-base',
        end_point = 'http://127.0.0.1:11434/v1/completions',
        name = 'Ollama',
        api_key = 'OLLAMA_API_KEY',
        optional = {
          optional = {
            max_tokens = 256,
            top_p = 0.9,
          },
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
      auto_trigger_ignore_ft = { 'AvanteInput' },
      keymap = {
        accept = '<Tab>',
        next = '<A-a>',
        dismiss = '<M-e>',
      },
    },
  },
}
