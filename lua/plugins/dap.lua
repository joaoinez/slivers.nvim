---@diagnostic disable: missing-fields

return {
  'mfussenegger/nvim-dap',
  enabled = true,
  dependencies = {
    'nvim-neotest/nvim-nio',
    'rcarriga/nvim-dap-ui',
    { 'theHamsta/nvim-dap-virtual-text', opts = {} },
    'jay-babu/mason-nvim-dap.nvim',
  },
  cmd = { 'DapInstall', 'DapUninstall' },
  keys = {
    {
      '<leader>dB',
      function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end,
      desc = 'Breakpoint Condition',
    },
    { '<leader>b', function() require('dap').toggle_breakpoint() end, desc = 'Toggle Breakpoint' },
    { '<leader>dc', function() require('dap').continue() end, desc = 'Continue' },
    { '<leader>de', function() require('dapui').eval() end, desc = 'Eval', mode = { 'n', 'v' } },
    { '<leader>di', function() require('dap').step_into() end, desc = 'Step Into' },
    { '<leader>dK', function() require('dap.ui.widgets').hover() end, desc = 'Inspect under cursor' },
    { '<leader>dl', function() require('dap').run_last() end, desc = 'Run Last' },
    { '<leader>do', function() require('dap').step_out() end, desc = 'Step Out' },
    { '<leader>dO', function() require('dap').step_over() end, desc = 'Step Over' },
    { '<leader>dr', function() require('dap').continue() end, desc = 'Run' },
    { '<leader>dp', function() require('dap').pause() end, desc = 'Pause' },
    { '<leader>dt', function() require('dap').terminate() end, desc = 'Terminate' },
    { '<leader>td', function() require('dapui').toggle {} end, desc = 'Debugger' },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local catppuccin = require('catppuccin.palettes').get_palette 'mocha'

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
    }

    dapui.setup { icons = IconSliver.dap.ui }

    vim.api.nvim_set_hl(0, 'DapBreak', { fg = catppuccin.red })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = catppuccin.yellow })

    for type, icon in pairs(IconSliver.dap.breakpoints) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'

      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open

    LangSliver.setup_dap_adapters(dap)
    LangSliver.setup_dap_configurations(dap)
  end,
}
