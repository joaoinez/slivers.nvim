local M = {}

M.highlighters = {
  'lua',
  'luadoc',
  'luap',
}

M.formatters = {
  'stylua',
}

M.formatters_by_ft = {
  lua = { 'stylua' },
}

return M
