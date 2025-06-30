local M = {}

local avante_models = {
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
  ['claude'] = {
    __inherited_from = 'claude',
    max_tokens = 8192,
  },
  ---@type AvanteSupportedProvider
  ['qwen2.5-coder-local'] = {
    __inherited_from = 'ollama',
    model = 'qwen2.5-coder:latest',
    disable_tools = true,
  },
}

function M.get_models()
  ---@type AvanteSupportedProvider[]
  local models = {}

  for model, config in pairs(require 'slivers.ai_models') do
    if config.avante then models[model] = config.avante end

    models[model].__inherited_from = 'openai'
    models[model].model = config.model
    models[model].endpoint = config.endpoint
    models[model].api_key_name = config.api_key_name
  end

  return models
end

return M
