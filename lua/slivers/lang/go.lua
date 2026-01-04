local M = {}

M.highlighters = {
  'go',
  'gomod',
  'gowork',
  'gosum',
}

M.linters = {
  'golangci-lint',
}

M.linters_by_ft = {
  go = { 'golangcilint' },
}

M.formatters = {
  'goimports',
  'gofumpt',
  'gomodifytags',
  'impl',
}

M.formatters_by_ft = {
  go = { 'goimports', 'gofumpt' },
}

M.debuggers = {
  'delve',
}

---@param dap table
function M.dap_adapters() require('dap-go').setup() end

--- NOTE: See https://github.com/golang/go/issues/54531#issuecomment-1464982242
---
--- @param client vim.lsp.Client
function M.semantic_token_workaround(client)
  if not client.server_capabilities.semanticTokensProvider then
    local semantic = client.config.capabilities.textDocument.semanticTokens
    if not semantic then return end

    client.server_capabilities.semanticTokensProvider = {
      full = true,
      legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
      range = true,
    }
  end
end

return M
