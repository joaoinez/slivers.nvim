---@diagnostic disable: missing-fields

---@type LazySpec
return {
  'folke/snacks.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  priority = 1002,
  lazy = false,
  keys = require 'plugins.snacks.keymaps',
  opts = {
    bigfile = require 'plugins.snacks.bigfile',
    dashboard = require 'plugins.snacks.dashboard',
    image = { enabled = true, force = true },
    indent = require 'plugins.snacks.indent',
    input = { enabled = true },
    notifier = { enabled = true, timeout = 3000 },
    picker = require 'plugins.snacks.picker',
    quickfile = { enabled = true },
    scope = { enabled = true },
    scratch = require 'plugins.snacks.scratch',
    statuscolumn = require 'plugins.snacks.statuscolumn',
    words = { enabled = true },
  },
  init = function()
    Slivers.autocmds.autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...) Snacks.debug.inspect(...) end
        _G.bt = function() Snacks.debug.backtrace() end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>ts'
        Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>tw'
        Snacks.toggle.option('relativenumber', { name = 'Relative Line Numbers' }):map '<leader>tL'
        Snacks.toggle.diagnostics():map '<leader>tx'
        Snacks.toggle.treesitter():map '<leader>tT'
        Snacks.toggle.inlay_hints():map '<leader>th'
        Snacks.toggle({
          name = 'Dark Mode',
          get = function() return vim.o.background == 'dark' end,
          set = function(state)
            if state then
              vim.o.background = 'dark'
            else
              vim.o.background = 'light'
            end
          end,
        }):map '<leader>tm'
      end,
    })
  end,
}
