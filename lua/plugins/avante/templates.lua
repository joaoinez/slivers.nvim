local M = {}

M.prefill_edit_window = function(_request)
  local request = 'Do not provide any explanation; just give the response directly. Do not include markdown code blocks; only the actual code. '
    .. _request
  require('avante.api').edit()
  local code_bufnr = vim.api.nvim_get_current_buf()
  local code_winid = vim.api.nvim_get_current_win()
  if code_bufnr == nil or code_winid == nil then return end
  vim.api.nvim_buf_set_lines(code_bufnr, 0, -1, false, { request })
  vim.api.nvim_win_set_cursor(code_winid, { 1, #request + 1 })
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-s>', true, true, true), 'v', true)
end

-- NOTE: most templates are inspired from ChatGPT.nvim -> chatgpt-actions.json
M.avante_keywords = 'Extract the main keywords from the following text'
M.avante_code_readability_analysis = [[
You must identify any readability issues in the code snippet.
Some readability issues to consider:
- Unclear naming
- Unclear purpose
- Redundant or obvious comments
- Lack of comments
- Long or complex one liners
- Too much nesting
- Long variable names
- Inconsistent naming and code style.
- Code repetition
You may identify additional problems. The user submits a small section of code from a larger file.
Only list lines with readability issues, in the format <line_num>|<issue and proposed solution>
If there's no issues with code respond with only: <OK>
]]
M.avante_explain_code = 'Explain the following code'
M.avante_complete_code = 'Complete the following code written in ' .. vim.bo.filetype
M.avante_add_docstring = 'Add comments to the following code'
M.avante_add_tests = 'Implement tests for the following code'

return M
