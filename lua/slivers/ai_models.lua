local M = {
  -- [[ Reasoning Models ]]

  ['gemini-2.5-pro'] = {
    endpoint = 'https://openrouter.ai/api/v1',
    api_key_name = 'OPENROUTER_API_KEY',
    model = 'google/gemini-2.5-pro-preview',
    avante = {
      max_tokens = 8192,
    },
    cost = '1.25$/input  | 10.00$/output',
  },
  ['o4-mini-high'] = {
    endpoint = 'https://openrouter.ai/api/v1',
    api_key_name = 'OPENROUTER_API_KEY',
    model = 'openai/o4-mini-high',
    avante = {
      max_tokens = 8192,
    },
    cost = '1.10$/input  |  4.40$/output',
  },
  ['deepseek-r1'] = {
    endpoint = 'https://openrouter.ai/api/v1',
    api_key_name = 'OPENROUTER_API_KEY',
    model = 'deepseek/deepseek-r1-0528',
    avante = {
      max_tokens = 8192,
    },
    cost = '0.50$/input  |  2.18$/output',
  },

  -- [[ Non-Reasoning Models ]]

  ['claude-4'] = {
    endpoint = 'https://openrouter.ai/api/v1',
    api_key_name = 'OPENROUTER_API_KEY',
    model = 'anthropic/claude-sonnet-4',
    avante = {
      max_tokens = 8192,
    },
    cost = '3.00$/input  | 15.00$/output',
  },
  ['qwen3'] = {
    endpoint = 'https://openrouter.ai/api/v1',
    api_key_name = 'OPENROUTER_API_KEY',
    model = 'qwen/qwen3-235b-a22b',
    avante = {
      max_tokens = 8192,
    },
    cost = '0.14$/input  |  0.60$/output',
  },
  ['deepseek-v3'] = {
    endpoint = 'https://openrouter.ai/api/v1',
    api_key_name = 'OPENROUTER_API_KEY',
    model = 'deepseek/deepseek-chat-v3-0324',
    avante = {
      max_tokens = 8192,
    },
    cost = '0.30$/input  |  0.88$/output',
  },
  ['gpt-4.1'] = {
    endpoint = 'https://openrouter.ai/api/v1',
    api_key_name = 'OPENROUTER_API_KEY',
    model = 'openai/gpt-4.1',
    avante = {
      max_tokens = 8192,
    },
    cost = '2.00$/input  |  8.00$/output',
  },
  ['devstral'] = {
    endpoint = 'https://openrouter.ai/api/v1',
    api_key_name = 'OPENROUTER_API_KEY',
    model = 'mistralai/devstral-small',
    avante = {
      max_tokens = 8192,
      disable_tools = true,
    },
    cost = '0.07$/input  |  0.10$/output',
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
