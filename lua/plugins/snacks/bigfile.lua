---@diagnostic disable: missing-fields

---@type snacks.bigfile.Config
local M = {
  enabled = true,
  setup = function(ctx)
    vim.cmd [[NoMatchParen]]
    Snacks.util.wo(0, { foldmethod = 'manual', statuscolumn = '', conceallevel = 0 })
    vim.b.minianimate_disable = true
    vim.schedule(function() vim.bo[ctx.buf].syntax = ctx.ft end)
  end,
}

return M
