local M = {}

--- @param client vim.lsp.Client|nil The client where the lsp mappings will load.
--- @param bufnr integer The bufnr where the lsp mappings will load.
function M.apply_user_lsp_mappings(client, bufnr)
  local builtin = require 'telescope.builtin'
  local supports = Slivers.lsp.supports(client)
  local map = Slivers.keymaps.safe_keymap_set

  map('n', 'gd', function() builtin.lsp_definitions() end, { desc = 'Goto Definition (telescope)' })
  map('n', 'gr', function() builtin.lsp_references() end, { desc = 'Goto References (telescope)' })
  map('n', 'gI', function() builtin.lsp_implementations() end, { desc = 'Goto Implementation (telescope)' })
  map('n', 'gy', function() builtin.lsp_type_definitions() end, { desc = 'Goto Type Definition (telescope)' })
  map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Goto Declaration' })
  map('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename Variable' })
  map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
  map('x', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
  map('x', '<leader>cl', vim.lsp.codelens.run, { desc = 'Code Lens' })
  map('n', '<leader>cA', Slivers.lsp.action.source, { desc = 'Available Code Actions' })

  if supports 'workspace_didRenameFiles' and supports 'workspace_willRenameFiles' then
    map('n', '<leader>cR', function() require('snacks').rename.rename_file() end, { desc = 'Rename File' })
  end

  if supports 'textDocument_documentHighlight' then
    map(
      'n',
      '<leader>th',
      function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }) end,
      { desc = 'Inlay Hints (lsp)' }
    )
  end
end

return M
