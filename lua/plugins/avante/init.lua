---@diagnostic disable: missing-fields

---@type LazySpec
return {
  'yetone/avante.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  build = 'make',
  event = 'VeryLazy',
  keys = {
    {
      '<leader>az',
      '<cmd>AvanteClear<cr>',
      desc = 'Clear Chat',
    },
  },
  opts = function()
    local model = vim.g.ai_model or ''
    local provider = model:gsub('%-dual', '')

    ---@type avante.Config
    local config = {
      provider = provider,
      cursor_applying_provider = model:match '%-local' and 'fastapply-local' or 'llama',
      auto_suggestions_provider = 'codestral',
      behaviour = {
        auto_suggestions = false,
        enable_cursor_planning_mode = true,
      },
      dual_boost = {
        enabled = model:match '%-dual' ~= nil,
        first_provider = 'gemini-2.5-pro',
        second_provider = 'o3-mini-high',
        prompt = [[
Analyze and synthesize the two reference implementations below to create an optimal solution that:

1. First evaluates technical merits:
   - Identifies overlapping correct patterns between both solutions
   - Flags any potential errors/antipatterns in either solution
   - Prioritizes solutions that better match existing codebase conventions
   - Prefers modern language features/idioms when appropriate

2. Maintains strict SEARCH/REPLACE format integrity:
   - Verify exact string matches for all SEARCH blocks against current file states
   - Ensure replace blocks maintain surrounding context stability
   - Cross-validate file paths between both solutions
   - Eliminate redundant or conflicting blocks

3. Resolve conflicts through:
   - Preferring solutions with proper error handling
   - Choosing better variable/function naming
   - Maintaining consistency with existing architectural patterns
   - Prioritizing performance where relevant

4. Final synthesis must:
   - Begin with clear explanation of combined approach
   - Group related file changes together
   - Maintain atomic, focused SEARCH/REPLACE blocks
   - Explicitly note improvements over individual references
   - Highlight any remaining tradeoffs/considerations

Reference Output 1: [{{provider1_output}}]
Reference Output 2: [{{provider2_output}}]

Produce final response that represents the most technically sound integration of these approaches while strictly following all formatting rules.
        ]],
        timeout = 60000 * 5,
      },
      rag_service = {
        enabled = false,
        embed_model = 'text-embedding-3-small',
      },
      ---@type AvanteLLMToolPublic[]
      custom_tools = {},
      disabled_tools = {
        'python',
      },
      ---@type AvanteSupportedProvider
      claude = {
        model = 'claude-3-5-sonnet-20241022',
        max_tokens = 8192,
      },
      vendors = {
        -- [[ Reasoning Models ]]

        ---@type AvanteSupportedProvider
        ['claude-reasoning'] = {
          __inherited_from = 'claude',
          model = 'claude-3-7-sonnet-20250219',
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
        ['o3-mini-high'] = {
          __inherited_from = 'openai',
          endpoint = 'https://openrouter.ai/api/v1',
          api_key_name = 'OPENROUTER_API_KEY',
          model = 'openai/o3-mini-high',
          max_tokens = 8192,
        },

        -- [[ Non-Reasoning Models ]]

        ---@type AvanteSupportedProvider
        ['claude-3.7'] = {
          __inherited_from = 'claude',
          model = 'claude-3-7-sonnet-20250219',
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
          model = 'deepseek/deepseek-chat',
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
        ---@type AvanteSupportedProvider
        ['fastapply-local'] = {
          __inherited_from = 'ollama',
          model = 'hf.co/Kortix/FastApply-1.5B-v1.0_GGUF:latest',
          disable_tools = true,
        },
      },
      mappings = {
        focus = '<leader>aF',
        toggle = {
          default = '<leader>ta',
        },
        files = {
          add_current = '<leader>af',
        },
        suggestion = {
          accept = '<Tab>',
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<M-e>',
        },
      },
      windows = {
        width = 40,
        input = {
          prefix = ' ',
        },
      },
      file_selector = {
        provider = 'snacks',
      },
    }

    return config
  end,
  config = function(_, opts)
    require('avante').setup(opts)
    require('plugins.avante.keymaps').load_keymaps()
  end,
  init = function()
    Slivers.autocmds.autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        _G.convert_to_qf = function()
          require('avante.diff').conflicts_to_qf_items(function(items)
            if #items > 0 then
              vim.fn.setqflist(items, 'r')
              vim.cmd 'copen'
            end
          end)
        end
      end,
    })
  end,
}
