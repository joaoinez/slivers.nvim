local M = {}

M.highlighters = {
  'json5',
  'jsdoc',
  'json',
  'jsonc',
}

M.formatters_by_ft = {
  json = { 'prettierd' },
  jsonc = { 'prettierd' },
}

return M
