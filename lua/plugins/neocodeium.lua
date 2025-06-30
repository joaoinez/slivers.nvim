---@type LazySpec
return {
  'monkoose/neocodeium',
  enabled = true,
  cond = not vim.g.vscode,
  event = { 'VeryLazy', 'InsertEnter' },
  config = function()
    local neocodeium = require 'neocodeium'

    neocodeium.setup { silent = true, manual = true }

    vim.keymap.set('i', '<s-tab>', neocodeium.accept)
    vim.keymap.set('i', '<m-l>', function() neocodeium.cycle_or_complete(1) end)
  end,
}
