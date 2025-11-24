---@type LazySpec
return {
  'nvim-neotest/neotest',
  enabled = true,
  cond = not vim.g.vscode,
  dependencies = {
    'antoinemadec/FixCursorHold.nvim',
    --[[ 'vim-test/vim-test',
    'nvim-neotest/neotest-vim-test', ]]
    'nvim-neotest/nvim-nio',
    -- 'nvim-neotest/neotest-plenary',
    -- 'nvim-neotest/neotest-jest',
    'joaoinez/neotest-bun',
  },
  keys = {
    { '<leader>n', '', desc = '+test' },
    { '<leader>nt', function() require('neotest').run.run(vim.fn.expand '%') end, desc = 'Run File (Neotest)' },
    { '<leader>nT', function() require('neotest').run.run(vim.uv.cwd()) end, desc = 'Run All Test Files (Neotest)' },
    { '<leader>nr', function() require('neotest').run.run() end, desc = 'Run Nearest (Neotest)' },
    { '<leader>nl', function() require('neotest').run.run_last() end, desc = 'Run Last (Neotest)' },
    { '<leader>ns', function() require('neotest').summary.toggle() end, desc = 'Toggle Summary (Neotest)' },
    {
      '<leader>no',
      function() require('neotest').output.open { enter = true, auto_close = true } end,
      desc = 'Show Output (Neotest)',
    },
    { '<leader>nO', function() require('neotest').output_panel.toggle() end, desc = 'Toggle Output Panel (Neotest)' },
    { '<leader>nS', function() require('neotest').run.stop() end, desc = 'Stop (Neotest)' },
    {
      '<leader>nw',
      function() require('neotest').watch.toggle(vim.fn.expand '%') end,
      desc = 'Toggle Watch (Neotest)',
    },
  },
  opts = function()
    return {
      adapters = {
        --[[ require 'neotest-jest' {
          jestCommand = 'npm test --',
          jestArguments = function(defaultArguments, context) return defaultArguments end,
          jestConfigFile = 'custom.jest.config.ts',
          env = { CI = true },
          cwd = function(path) return vim.fn.getcwd() end,
          isTestFile = require('neotest-jest.jest-util').defaultIsTestFile,
        }, ]]
        require 'neotest-bun',
      },
      output = { open_on_run = true },
      quickfix = {
        open = function() require('trouble').open { mode = 'quickfix', focus = false } end,
      },
    }
  end,
  config = function(_, opts)
    local neotest_ns = vim.api.nvim_create_namespace 'neotest'
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          -- Replace newline and tab characters with space for more compact diagnostics
          local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
          return message
        end,
      },
    }, neotest_ns)

    opts.consumers = opts.consumers or {}
    -- Refresh and auto close trouble after running tests
    ---@type neotest.Consumer
    opts.consumers.trouble = function(client)
      client.listeners.results = function(adapter_id, results, partial)
        if partial then return end
        local tree = assert(client:get_position(nil, { adapter = adapter_id }))

        local failed = 0
        for pos_id, result in pairs(results) do
          if result.status == 'failed' and tree:get_key(pos_id) then failed = failed + 1 end
        end
        vim.schedule(function()
          local trouble = require 'trouble'
          if trouble.is_open() then
            trouble.refresh()
            if failed == 0 then trouble.close() end
          end
        end)
        return {}
      end
    end

    require('neotest').setup(opts)
  end,
}
