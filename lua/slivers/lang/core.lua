local M = {}

M.highlighters = vim.tbl_deep_extend('force', {
  'c',
  'diff',
  'html',
  'http',
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
}, vim.fn.has 'macos' == 1 and {
  'latex',
} or {})

M.ft_with_disabled_formatters = {
  c = true,
  cpp = true,
}

return M
