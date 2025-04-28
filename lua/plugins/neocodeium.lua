return {
  'monkoose/neocodeium',
  event = { 'VeryLazy', 'InsertEnter' },
  config = function()
    local neocodeium = require 'neocodeium'
    neocodeium.setup { silent = true }
    vim.keymap.set('i', '<tab>', neocodeium.accept)
  end,
}
