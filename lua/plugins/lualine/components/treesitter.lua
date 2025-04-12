local function M()
  local bufnr = vim.api.nvim_get_current_buf()

  local parser = vim.treesitter.get_parser(bufnr, nil, { error = false })

  if parser then
    -- The parser object has a lang() method that returns the language string
    local lang_name = parser:lang()
    return lang_name
  else
    return 'plain text'
  end
end

return M
