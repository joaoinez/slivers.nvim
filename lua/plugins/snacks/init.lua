---@diagnostic disable: missing-fields

return {
  'folke/snacks.nvim',
  enabled = true,
  priority = 1000,
  lazy = false,
  keys = require('plugins.snacks.keymaps').keys,
  opts = {
    bigfile = {
      enabled = true,
      setup = function(ctx)
        vim.cmd [[NoMatchParen]]
        require('snacks').util.wo(0, { foldmethod = 'manual', statuscolumn = '', conceallevel = 0 })
        vim.b.minianimate_disable = true
        vim.b.minimap_disable = true
        vim.schedule(function() vim.bo[ctx.buf].syntax = ctx.ft end)
      end,
    },
    dashboard = require('plugins.snacks.dashboard').config,
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
}
