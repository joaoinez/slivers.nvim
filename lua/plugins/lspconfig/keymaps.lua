---@diagnostic disable: unused-local

local M = {}

--- @param client vim.lsp.Client|nil The client where the lsp mappings will load.
--- @param bufnr integer The bufnr where the lsp mappings will load.
function M.apply_user_lsp_mappings(client, bufnr)
  local supports = Slivers.lsp.supports(client)
  local map = Slivers.keymaps.safe_keymap_set

  -- TODO: Check for picker and add fallbacks
  --
  -- { "gd", vim.lsp.buf.definition, desc = "Goto Definition" },
  -- { "gr", vim.lsp.buf.references, desc = "References", nowait = true },
  -- { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
  -- { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
  -- { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
  map('n', 'gd', function() Snacks.picker.lsp_definitions() end, { desc = 'Goto Definition (snacks)' })
  map('n', 'gr', function() Snacks.picker.lsp_references() end, { desc = 'Goto References (snacks)', nowait = true })
  map('n', 'gI', function() Snacks.picker.lsp_implementations() end, { desc = 'Goto Implementation (snacks)' })
  map('n', 'gt', function() Snacks.picker.lsp_type_definitions() end, { desc = 'Goto Type Definition (snacks)' })
  map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Goto Declaration' })
  map('n', 'gK', function() return vim.lsp.buf.signature_help() end, { desc = 'Signature Help' })
  map('i', '<C-k>', function() return vim.lsp.buf.signature_help() end, { desc = 'Signature Help' })
  map('n', '<leader>cr', function() require('plugins.lspconfig.utils').lsp_rename() end, { desc = 'Rename Variable' })
  map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
  map('x', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
  map('x', '<leader>cl', vim.lsp.codelens.run, { desc = 'Code Lens' })
  map('n', '<leader>cA', Slivers.lsp.action.source, { desc = 'Available Code Actions' })

  if supports 'workspace_didRenameFiles' and supports 'workspace_willRenameFiles' then
    map('n', '<leader>cR', function() Snacks.rename.rename_file() end, { desc = 'Rename File' })
  end
end

return M
