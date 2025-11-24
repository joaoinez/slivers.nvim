local M = {}

M.lsp = function()
  local base_on_attach = vim.lsp.config.eslint.on_attach
  vim.lsp.config('eslint', {
    on_attach = function(client, bufnr)
      if not base_on_attach then return end

      base_on_attach(client, bufnr)
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = bufnr,
        callback = function()
          local clients = vim.lsp.get_clients { bufnr = bufnr, name = 'eslint' }
          if
            clients
            and clients[1]
            and clients[1].server_capabilities
            and clients[1].server_capabilities.codeActionProvider
          then
            ---@diagnostic disable-next-line: param-type-mismatch
            pcall(vim.cmd, 'LspEslintFixAll')
          end
        end,
      })
    end,
  })
end

return M
