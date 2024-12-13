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
  cmd = { 'DapInstall', 'DapUninstall' },
  keys = {
    -- TODO: Change keymaps
    {
      '<leader>dB',
      function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end,
      desc = 'Breakpoint Condition',
    },
    { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle Breakpoint' },
    { '<leader>dc', function() require('dap').continue() end, desc = 'Run/Continue' },
    {
      '<leader>da',
      function()
        ---@param config {type?:string, args?:string[]|fun():string[]?}
        local function get_args(config)
          local args = type(config.args) == 'function' and (config.args() or {}) or config.args or {} --[[@as string[] | string ]]
          local args_str = type(args) == 'table' and table.concat(args, ' ') or args --[[@as string]]

          config = vim.deepcopy(config)
          ---@cast args string[]
          config.args = function()
            local new_args = vim.fn.expand(vim.fn.input('Run with args: ', args_str)) --[[@as string]]
            if config.type and config.type == 'java' then
              ---@diagnostic disable-next-line: return-type-mismatch
              return new_args
            end
            return require('dap.utils').splitstr(new_args)
          end
          return config
        end

        require('dap').continue { before = get_args }
      end,
      desc = 'Run with Args',
    },
    { '<leader>dC', function() require('dap').run_to_cursor() end, desc = 'Run to Cursor' },
    { '<leader>dg', function() require('dap').goto_() end, desc = 'Go to Line (No Execute)' },
    { '<leader>di', function() require('dap').step_into() end, desc = 'Step Into' },
    { '<leader>dj', function() require('dap').down() end, desc = 'Down' },
    { '<leader>dk', function() require('dap').up() end, desc = 'Up' },
    { '<leader>dl', function() require('dap').run_last() end, desc = 'Run Last' },
    { '<leader>do', function() require('dap').step_out() end, desc = 'Step Out' },
    { '<leader>dO', function() require('dap').step_over() end, desc = 'Step Over' },
    { '<leader>dp', function() require('dap').pause() end, desc = 'Pause' },
    { '<leader>ds', function() require('dap').session() end, desc = 'Session' },
    { '<leader>dt', function() require('dap').terminate() end, desc = 'Terminate' },
    { '<leader>dw', function() require('dap.ui.widgets').hover() end, desc = 'Widgets' },
    { '<leader>td', function() require('dapui').toggle {} end, desc = 'Dap UI' },
    { '<leader>de', function() require('dapui').eval() end, desc = 'Eval', mode = { 'n', 'v' } },
  },
  lazy = false,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local mocha = require('catppuccin.palettes').get_palette 'mocha'
    local lang = require 'config.lang'

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
    }

    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    }

    vim.api.nvim_set_hl(0, 'DapBreak', { fg = mocha.red })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = mocha.yellow })

    local breakpoint_icons = {
      Breakpoint = '',
      BreakpointCondition = '',
      BreakpointRejected = '',
      LogPoint = '',
      Stopped = '',
    }

    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'

      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open

    lang.setup_dap_adapters(dap)
    lang.setup_dap_configurations(dap)
  end,
}
