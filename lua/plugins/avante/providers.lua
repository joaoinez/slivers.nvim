local M = {
  -- [[ Reasoning Models ]]

  ---@type AvanteSupportedProvider
  ['claude-reasoning'] = {
    __inherited_from = 'claude',
    max_tokens = 8192,
    temperature = 1,
    thinking = {
      type = 'enabled',
      budget_tokens = 4096,
    },
  },
  ---@type AvanteSupportedProvider
  ['gemini-2.5-pro'] = {
    __inherited_from = 'openai',
    endpoint = 'https://openrouter.ai/api/v1',
    api_key_name = 'OPENROUTER_API_KEY',
    model = 'google/gemini-2.5-pro-exp-03-25:free',
    max_tokens = 8192,
  },
  ---@type AvanteSupportedProvider
  ['deepseek-r1'] = {
    __inherited_from = 'openai',
    endpoint = 'https://openrouter.ai/api/v1',
    api_key_name = 'OPENROUTER_API_KEY',
    model = 'deepseek/deepseek-r1',
    max_tokens = 8192,
  },
  ---@type AvanteSupportedProvider
  ['o4-mini-high'] = {
    __inherited_from = 'openai',
    endpoint = 'https://openrouter.ai/api/v1',
    api_key_name = 'OPENROUTER_API_KEY',
    model = 'openai/o4-mini-high',
    max_tokens = 8192,
  },

  -- [[ Non-Reasoning Models ]]

  ---@type AvanteSupportedProvider
  ['claude-3.7'] = {
    __inherited_from = 'openai',
    endpoint = 'https://openrouter.ai/api/v1',
    api_key_name = 'OPENROUTER_API_KEY',
    model = 'anthropic/claude-3.7-sonnet',
    max_tokens = 8192,
  },
  ---@type AvanteSupportedProvider
  ['deepseek-v3'] = {
    __inherited_from = 'openai',
    endpoint = 'https://openrouter.ai/api/v1',
    api_key_name = 'OPENROUTER_API_KEY',
    model = 'deepseek/deepseek-chat-v3-0324',
    max_tokens = 8192,
  },
  ---@type AvanteSupportedProvider
  ['gpt-4.1-mini'] = {
    __inherited_from = 'openai',
    endpoint = 'https://openrouter.ai/api/v1',
    api_key_name = 'OPENROUTER_API_KEY',
    model = 'openai/gpt-4.1-mini',
    max_tokens = 8192,
  },
  ---@type AvanteSupportedProvider
  ['qwen2.5-coder'] = {
    __inherited_from = 'openai',
    endpoint = 'https://api.groq.com/openai/v1/',
    api_key_name = 'GROQ_API_KEY',
    model = 'qwen-2.5-coder-32b',
    max_tokens = 8192,
  },
  ---@type AvanteSupportedProvider
  ['mistral-small'] = {
    __inherited_from = 'openai',
    endpoint = 'https://openrouter.ai/api/v1',
    api_key_name = 'OPENROUTER_API_KEY',
    model = 'mistralai/mistral-small-3.1-24b-instruct',
    max_tokens = 8192,
    disable_tools = true,
  },
  ---@type AvanteSupportedProvider
  ['codestral'] = {
    __inherited_from = 'openai',
    endpoint = 'https://openrouter.ai/api/v1',
    api_key_name = 'OPENROUTER_API_KEY',
    model = 'mistralai/codestral-2501',
    max_tokens = 128,
    disable_tools = true,
  },
  ---@type AvanteSupportedProvider
  ['llama'] = {
    __inherited_from = 'openai',
    api_key_name = 'GROQ_API_KEY',
    endpoint = 'https://api.groq.com/openai/v1/',
    model = 'llama-3.3-70b-versatile',
    max_tokens = 8192,
    disable_tools = true,
  },
  ---@type AvanteSupportedProvider
  ['qwen2.5-coder-local'] = {
    __inherited_from = 'ollama',
    model = 'qwen2.5-coder:latest',
    disable_tools = true,
  },
}

return M
