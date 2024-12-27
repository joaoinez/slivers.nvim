local M = {}

M.highlighters = {
  'markdown',
  'markdown_inline',
}

M.formatters_by_ft = {
  ['markdown'] = { 'prettier', 'markdownlint-cli2' },
  ['markdown.mdx'] = { 'prettier', 'markdownlint-cli2' },
}

M.linters = {
  'markdownlint-cli2',
}

M.linters_by_ft = {
  markdown = { 'markdownlint-cli2' },
}

return M
