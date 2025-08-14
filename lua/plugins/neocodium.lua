---@type LazySpec
return {
  'monkoose/neocodeium',
  enabled = false,
  cond = not vim.g.vscode and vim.g.ai_completion == 'neocodeium',
  event = { 'VeryLazy', 'InsertEnter' },
  config = function()
    local neocodeium = require 'neocodeium'

    neocodeium.setup { silent = true }

    vim.keymap.set('i', '<tab>', neocodeium.accept)
    -- vim.keymap.set('i', '<m-l>', function() neocodeium.cycle_or_complete(1) end)
  end,
}
