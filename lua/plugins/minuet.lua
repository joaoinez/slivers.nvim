---@type LazySpec
return {
  'milanglacier/minuet-ai.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePost' },
  opts = {
    provider = 'openai_compatible',
    request_timeout = 2.5,
    throttle = 1500,
    debounce = 600,
    provider_options = {
      openai_compatible = {
        api_key = 'OPENROUTER_API_KEY',
        end_point = 'https://openrouter.ai/api/v1/chat/completions',
        model = 'mistralai/codestral-2501',
        -- model = 'google/gemini-2.0-flash-001',
        name = 'Openrouter',
        optional = {
          max_tokens = 128,
          top_p = 0.9,
          provider = {
            sort = 'throughput',
          },
        },
      },
    },
    virtualtext = {
      auto_trigger_ft = { '*' },
      auto_trigger_ignore_ft = { 'snacks_picker_input' },
      keymap = {
        accept = '<A-y>',
        accept_line = '<Tab>',
        prev = '<A-[>',
        next = '<A-]>',
        dismiss = '<A-e>',
      },
    },
    n_completions = 1,
  },
}
