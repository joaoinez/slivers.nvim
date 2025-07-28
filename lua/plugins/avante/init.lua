---@diagnostic disable: missing-fields

---@type LazySpec
return {
  'yetone/avante.nvim',
  enabled = false,
  cond = not vim.g.vscode,
  dependencies = {
    'ravitemer/mcphub.nvim',
    build = 'npm install -g mcp-hub@latest',
    cmd = { 'MCPHub' },
    keys = {
      {
        '<leader>,h',
        '<cmd>MCPHub<cr>',
        desc = 'MCP Hub',
      },
    },
    opts = {
      auto_approve = true,
      extensions = {
        avante = {
          make_slash_commands = true,
        },
      },
    },
  },
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
      memory_summary_provider = model:match '%-local' and 'qwen2.5-coder-local' or 'llama',
      behaviour = {
        auto_suggestions = false,
        -- auto_apply_diff_after_generation = true,
        -- jump_result_buffer_on_finish = true,
      },
      dual_boost = {
        enabled = model:match '%-dual' ~= nil,
        first_provider = 'gemini-2.5-pro',
        second_provider = 'o4-mini-high',
        prompt = require('plugins.avante.templates').avante_dual_boost,
        timeout = 60000 * 5,
      },
      ---@type AvanteSupportedProvider
      providers = require('plugins.avante.providers').get_models(),
      mappings = require('plugins.avante.keymaps').mappings,
      windows = {
        width = 40,
        input = {
          prefix = ' ',
        },
      },
      file_selector = {
        provider = 'snacks',
      },
      selector = {
        provider = 'snacks',
      },

      -- [[ MCP Hub ]]
      -- The system_prompt type supports both a string and a function that returns a string. Using a function here allows dynamically updating the prompt with mcphub
      system_prompt = function()
        local prompt = nil
        local hub = require('mcphub').get_hub_instance()

        if model == 'qwen3' then prompt = '/no_think ' end
        if hub then prompt = (prompt or '') .. hub:get_active_servers_prompt() end

        return prompt
      end,
      -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
      custom_tools = function()
        return {
          require('mcphub.extensions.avante').mcp_tool(),
        }
      end,
      disabled_tools = {
        'python',
        'run_python',
        'list_files',
        'search_files',
        'read_file',
        'create_file',
        'rename_file',
        'delete_file',
        'create_dir',
        'rename_dir',
        'delete_dir',
        'bash',
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
