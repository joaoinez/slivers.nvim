local M = {}

M.highlighters = {
  'bash',
  'c',
  'diff',
  'html',
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
