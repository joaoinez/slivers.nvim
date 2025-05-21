---@diagnostic disable: missing-fields

---@type LazySpec
return {
  'folke/snacks.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  priority = 1002,
  lazy = false,
  keys = require 'plugins.snacks.keymaps',
  ---@type snacks.Config
  opts = {
    bigfile = require 'plugins.snacks.bigfile',
    dashboard = require 'plugins.snacks.dashboard',
    image = { enabled = true, force = true, doc = { enabled = false } },
    indent = require 'plugins.snacks.indent',
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
      ---@type snacks.notifier.style
      style = 'fancy',
    },
    picker = require 'plugins.snacks.picker',
    quickfile = { enabled = true },
    scope = { enabled = true },
    scratch = require 'plugins.snacks.scratch',
    statuscolumn = require 'plugins.snacks.statuscolumn',
    words = { enabled = true },
    ---@type table<string, snacks.win.Config>
    styles = {
      notification = {
        wo = {
          wrap = true,
        },
      },
    },
  },
  init = function()
    Slivers.autocmds.autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...) Snacks.debug.inspect(...) end
        _G.bt = function() Snacks.debug.backtrace() end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        require 'plugins.snacks.toggle'
      end,
    })
  end,
}
