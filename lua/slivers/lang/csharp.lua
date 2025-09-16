local M = {}

M.highlighters = {
  'c_sharp',
  'razor',
}

M.formatters = {
  'csharpier',
}

M.formatters_by_ft = {
  cs = { 'csharpier' },
}

return M
