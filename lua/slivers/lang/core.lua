local M = {}

M.highlighters = {
  'c',
  'diff',
  'html',
  'http',
  'printf',
  'python',
  'query',
  'regex',
  'toml',
  'vim',
  'vimdoc',
  'xml',
}

M.ft_with_disabled_formatters = {
  c = true,
  cpp = true,
}

return M
