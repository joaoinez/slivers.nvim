return {
  Macro = { fg = vim.api.nvim_get_hl(0, { name = 'Statement' }).fg },
  Lsp = { fg = vim.api.nvim_get_hl(0, { name = 'String' }).fg },
  Lazy = { fg = vim.api.nvim_get_hl(0, { name = 'Identifier' }).fg },
  Break = { fg = vim.api.nvim_get_hl(0, { name = 'Error' }).fg },
  Stop = { fg = vim.api.nvim_get_hl(0, { name = 'WarningMsg' }).fg },
}
