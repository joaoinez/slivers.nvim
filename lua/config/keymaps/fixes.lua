local utils = require 'utils'
local maps = utils.get_mappings_template()

-- Prevent Tab from behaving like `<C-i>`
maps.n['<Tab>'] = {
  '<Tab>',
  noremap = true,
  silent = true,
  expr = false,
  desc = 'FIX: Prevent Tab from behaving like <C-i>, as they share the same internal code',
}

utils.set_mappings(maps)
