---@diagnostic disable: missing-fields

---@type LazySpec
return {
  'mfussenegger/nvim-dap',
  enabled = true,
  cond = not vim.g.vscode,
  dependencies = {
    {
      'igorlfs/nvim-dap-view',
      ---@module 'dap-view'
      ---@type dapview.Config
      opts = {
        auto_toggle = true,
        winbar = {
          sections = { 'scopes', 'watches', 'exceptions', 'breakpoints', 'threads', 'repl', 'console' },
          default_section = 'scopes',
          controls = {
            enabled = true,
          },
        },
      },
    },
    { 'theHamsta/nvim-dap-virtual-text', opts = {} },
    'jay-babu/mason-nvim-dap.nvim',

    { 'leoluz/nvim-dap-go', ft = { 'go' } },
    { 'Cliffback/netcoredbg-macOS-arm64.nvim', ft = { 'cs' } },
  },
  cmd = { 'DapInstall', 'DapUninstall' },
  -- NOTE: See https://codeberg.org/mfussenegger/nvim-dap/src/branch/master/doc/dap.txt
  keys = {
    { '<leader>b', function() require('dap').toggle_breakpoint() end, desc = 'Toggle Breakpoint' },
    {
      '<leader>dB',
      function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end,
      desc = 'Breakpoint Condition',
    },
    { '<leader>dc', function() require('dap').continue() end, desc = 'Continue' },
    { '<leader>di', function() require('dap').step_into() end, desc = 'Step Into' },
    { '<leader>dl', function() require('dap').run_last() end, desc = 'Run Last' },
    { '<leader>ds', function() require('dap').step_over() end, desc = 'Step' },
    { '<leader>dO', function() require('dap').step_out() end, desc = 'Step Out' },
    { '<leader>dp', function() require('dap').pause() end, desc = 'Pause' },
    { '<leader>dr', function() require('dap').continue() end, desc = 'Run' },
    { '<leader>dt', function() require('dap').terminate() end, desc = 'Terminate' },
    { '<leader>dK', function() require('dap.ui.widgets').hover() end, desc = 'Hover' },
    { '<leader>dL', '<cmd>DapShowLog<cr>', desc = 'Open DAP Log' },
    { '<leader>td', function() require('dap-view').toggle() end, desc = 'Debugger' },
  },
  config = function()
    local dap = require 'dap'

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
    }

    vim.api.nvim_set_hl(0, 'DapBreak', { link = 'SliversBreak' })
    vim.api.nvim_set_hl(0, 'DapStop', { link = 'SliversStop' })

    for type, icon in pairs(IconSliver.dap.breakpoints) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'

      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    --[[ -- NOTE: See https://codeberg.org/mfussenegger/nvim-dap/wiki/Cookbook#map-k-to-hover-while-session-is-active

    local api = vim.api
    local keymap_restore = {}
    dap.listeners.after['event_initialized']['me'] = function()
      for _, buf in pairs(api.nvim_list_bufs()) do
        local keymaps = api.nvim_buf_get_keymap(buf, 'n')
        for _, keymap in pairs(keymaps) do
          if keymap.lhs == 'K' then
            table.insert(keymap_restore, keymap)
            api.nvim_buf_del_keymap(buf, 'n', 'K')
          end
        end
      end
      api.nvim_set_keymap('n', 'K', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
    end

    dap.listeners.after['event_terminated']['me'] = function()
      for _, keymap in pairs(keymap_restore) do
        if keymap.rhs then
          api.nvim_buf_set_keymap(keymap.buffer, keymap.mode, keymap.lhs, keymap.rhs, { silent = keymap.silent == 1 })
        elseif keymap.callback then
          vim.keymap.set(
            keymap.mode,
            keymap.lhs,
            keymap.callback,
            { buffer = keymap.buffer, silent = keymap.silent == 1 }
          )
        end
      end
      keymap_restore = {}
    end ]]

    LangSliver.setup_dap_adapters(dap)
    LangSliver.setup_dap_configurations(dap)
  end,
}
