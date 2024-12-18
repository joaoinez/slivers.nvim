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
    indent = {
      enabled = true,
      indent = {
        enabled = false,
      },
      animate = {
        enabled = false,
      },
    },
    input = { enabled = false },
    quickfile = { enabled = true },
    scratch = {
      enabled = true,
      ft = function()
        if vim.bo.buftype == '' and vim.bo.filetype ~= '' then
          return vim.bo.filetype == 'lua' and vim.bo.filetype or 'markdown'
        end
        return 'markdown'
      end,
    },
    scroll = { enabled = false },
    scope = { enabled = true },
    statuscolumn = { enabled = false },
    words = { enabled = true },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...) require('snacks').debug.inspect(...) end
        _G.bt = function() require('snacks').debug.backtrace() end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        require('snacks').toggle.option('spell', { name = 'Spelling' }):map '<leader>ts'
        require('snacks').toggle.option('wrap', { name = 'Wrap' }):map '<leader>tw'
        require('snacks').toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>tL'
        require('snacks').toggle.diagnostics():map '<leader>tx'
        require('snacks').toggle.treesitter():map '<leader>tT'
        require('snacks').toggle.inlay_hints():map '<leader>th'
      end,
    })
  end,
}
