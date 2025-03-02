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
    local models = {
      'ollama-qwen', -- mode 1
      'qwen2.5-coder', -- mode 2
      'qwen2.5-coder', -- mode 3
      'claude', -- mode 4
      'claude', -- mode 5
      'claude-reasoning', -- mode 6
    }

    ---@type avante.Config
    return {
      provider = models[vim.g.ai_mode] or nil,
      cursor_applying_provider = vim.g.ai_mode > 1 and 'groq-llama' or 'ollama-fastapply',
      auto_suggestions_provider = 'codestral',
      behaviour = {
        auto_suggestions = false,
        enable_cursor_planning_mode = true,
      },
      dual_boost = {
        enabled = vim.g.ai_mode == 3 or vim.g.ai_mode == 5,
        first_provider = 'deepseek-r1',
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
        enabled = true,
      },
      ---@type AvanteSupportedProvider
      claude = {
        max_tokens = 8192,
      },
      vendors = {
        -- Reasoning Models
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
        ['deepseek-r1'] = {
          __inherited_from = 'openai',
          endpoint = 'https://openrouter.ai/api/v1',
          api_key_name = 'OPENROUTER_API_KEY',
          model = 'deepseek/deepseek-r1',
          max_tokens = 8192,
          disable_tools = true,
        },
        ---@type AvanteSupportedProvider
        ['o3-mini-high'] = {
          __inherited_from = 'openai',
          endpoint = 'https://openrouter.ai/api/v1',
          api_key_name = 'OPENROUTER_API_KEY',
          model = 'openai/o3-mini-high',
          max_tokens = 8192,
        },
        -- Non-Reasoning Models
        ---@type AvanteSupportedProvider
        ['qwen2.5-coder'] = {
          __inherited_from = 'openai',
          endpoint = 'https://openrouter.ai/api/v1',
          api_key_name = 'OPENROUTER_API_KEY',
          model = 'qwen/qwen-2.5-coder-32b-instruct',
          max_tokens = 8192,
          disable_tools = true,
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
        ['groq-llama'] = {
          __inherited_from = 'openai',
          api_key_name = 'GROQ_API_KEY',
          endpoint = 'https://api.groq.com/openai/v1/',
          model = 'llama-3.3-70b-versatile',
          max_tokens = 32768,
        },
        ['ollama-qwen'] = require('plugins.avante.ollama').model 'qwen2.5-coder:latest',
        ['ollama-fastapply'] = require('plugins.avante.ollama').model 'hf.co/Kortix/FastApply-1.5B-v1.0_GGUF:latest',
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
