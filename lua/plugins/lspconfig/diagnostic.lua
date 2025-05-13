local icons = IconSliver.diagnostics

vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.error,
      [vim.diagnostic.severity.WARN] = icons.warn,
      [vim.diagnostic.severity.HINT] = icons.hint,
      [vim.diagnostic.severity.INFO] = icons.info,
    },
  },
  virtual_lines = {
    current_line = true,
  },
  -- virtual_text = {
  --   spacing = 4,
  --   source = 'if_many',
  --   prefix = function(diagnostic)
  --     local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1
  --     return (diagnostic.lnum ~= current_line) and icons.virtual or icons.down
  --   end,
  --   format = function(diagnostic)
  --     local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1
  --     return (diagnostic.lnum ~= current_line) and diagnostic.message or ''
  --   end,
  -- },
}

-- autocmd({ 'CursorMoved', 'CursorMovedI' }, {
--   group = augroup 'diagnostic_refresh',
--   callback = function()
--     vim.diagnostic.hide()
--     vim.diagnostic.show()
--   end,
-- })
