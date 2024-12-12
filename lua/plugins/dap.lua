---@diagnostic disable: missing-fields
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'rcarriga/nvim-dap-ui',
    { 'theHamsta/nvim-dap-virtual-text', opts = {} },
    'mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
  keys = {
    { '<leader>db', function() require('dap').toggle_breakpoint() end },
    { '<leader>dc', function() require('dap').continue() end },
    { '<leader>du', function() require('dapui').toggle() end },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local utils = require 'utils'

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
    }

    dapui.setup()

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    require('dap').adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'node',
        -- 💀 Make sure to update this path to point to your installation
        args = {
          utils.get_pkg_path('js-debug-adapter', '/js-debug/src/dapDebugServer.js'),
          '${port}',
        },
      },
    }

    local js_filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }

    for _, language in ipairs(js_filetypes) do
      require('dap').configurations[language] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
      }
    end
  end,
}
