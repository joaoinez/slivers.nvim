local M = {}

function M.get_models()
  ---@type table<string, table|function>
  local models = {
    opts = {
      show_defaults = false,
    },
  }

  for model, config in pairs(require 'slivers.ai_models') do
    models[model] = function()
      return require('codecompanion.adapters').extend('openai_compatible', {
        env = {
          url = config.endpoint,
          api_key = config.api_key_name,
          chat_url = '/chat/completions',
        },
        schema = {
          model = {
            default = config.model,
          },
        },
      })
    end
  end

  return models
end

return M
