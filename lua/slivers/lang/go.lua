local M = {}

M.highlighters = {
  'go',
  'gomod',
  'gowork',
  'gosum',
}

M.formatters = {
  'goimports',
  'gofumpt',
  'gomodifytags',
  'impl',
}

M.formatters_by_ft = {
  go = { 'goimports', 'gofumpt' },
}

M.debuggers = {
  'delve',
}

return M
