local M = {
  -- [[ Reasoning Models ]]

  ['gemini-2.5-pro'] = {
    endpoint = 'https://openrouter.ai/api/v1',
    api_key_name = 'OPENROUTER_API_KEY',
    model = 'google/gemini-2.5-pro-preview',
    avante = {
      max_tokens = 8192,
    },
  },
  ['deepseek-r1'] = {
    endpoint = 'https://openrouter.ai/api/v1',
    api_key_name = 'OPENROUTER_API_KEY',
    model = 'deepseek/deepseek-r1',
    avante = {
      max_tokens = 8192,
    },
  },
  ['o4-mini-high'] = {
    endpoint = 'https://openrouter.ai/api/v1',
    api_key_name = 'OPENROUTER_API_KEY',
    model = 'openai/o4-mini-high',
    avante = {
      max_tokens = 8192,
    },
  },

  -- [[ Non-Reasoning Models ]]

  ['claude-3.7'] = {
    endpoint = 'https://openrouter.ai/api/v1',
    api_key_name = 'OPENROUTER_API_KEY',
    model = 'anthropic/claude-3.7-sonnet',
    avante = {
      max_tokens = 8192,
    },
  },
  ['qwen3'] = {
    endpoint = 'https://openrouter.ai/api/v1',
    api_key_name = 'OPENROUTER_API_KEY',
    model = 'qwen/qwen3-235b-a22b',
    avante = {
      max_tokens = 8192,
    },
  },
  ['deepseek-v3'] = {
    endpoint = 'https://openrouter.ai/api/v1',
    api_key_name = 'OPENROUTER_API_KEY',
    model = 'deepseek/deepseek-chat-v3-0324',
    avante = {
      max_tokens = 8192,
    },
  },
  ['gpt-4.1-mini'] = {
    endpoint = 'https://openrouter.ai/api/v1',
    api_key_name = 'OPENROUTER_API_KEY',
    model = 'openai/gpt-4.1-mini',
    avante = {
      max_tokens = 8192,
    },
  },
  ['mistral-small'] = {
    endpoint = 'https://openrouter.ai/api/v1',
    api_key_name = 'OPENROUTER_API_KEY',
    model = 'mistralai/mistral-small-3.1-24b-instruct',
    avante = {
      max_tokens = 8192,
      disable_tools = true,
    },
  },
  ['llama'] = {
    endpoint = 'https://api.groq.com/openai/v1/',
    api_key_name = 'GROQ_API_KEY',
    model = 'llama-3.3-70b-versatile',
    avante = {
      max_tokens = 8192,
      disable_tools = true,
    },
  },
}

return M
