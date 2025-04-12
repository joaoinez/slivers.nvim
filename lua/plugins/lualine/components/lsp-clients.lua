local function M()
  local bufnr = vim.api.nvim_get_current_buf()

  local clients = Slivers.lsp.get_clients { bufnr = bufnr }
  if next(clients) == nil then return '' end

  local c = {}
  for _, client in pairs(clients) do
    table.insert(c, IconSliver.lualine.lsp[client.name] or client.name)
  end

  return table.concat(c, ' ')
end

return M
