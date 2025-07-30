local M = {}

M.highlighters = {
  'c',
  'diff',
  'html',
  'http',
  'latex',
  'norg',
  'printf',
  'query',
  'regex',
  'toml',
  'typst',
  'vim',
  'vimdoc',
  'xml',
  'kdl',
}

M.ft_with_disabled_formatters = {
  c = true,
  cpp = true,
}

return M
