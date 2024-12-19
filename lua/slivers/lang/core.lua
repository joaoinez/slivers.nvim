local M = {}

M.highlighters = {
  'bash',
  'c',
  'diff',
  'html',
  'jsdoc',
  'json',
  'jsonc',
  'markdown',
  'markdown_inline',
  'printf',
  'python',
  'query',
  'regex',
  'toml',
  'vim',
  'vimdoc',
  'xml',
  'yaml',
}

M.ft_with_disabled_formatters = {
  c = true,
  cpp = true,
}

return M
