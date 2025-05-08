local M = {}

M.highlighters = {
  'bash',
}

M.formatters = {
  'shfmt',
}

M.formatters_by_ft = {
  sh = { 'shfmt' },
}

M.linters = {
  'shellcheck',
}

M.linters_by_ft = {
  sh = { 'shellcheck' },
}

return M
