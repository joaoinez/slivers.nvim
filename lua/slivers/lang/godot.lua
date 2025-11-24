local M = {}

M.highlighters = {
  'gdscript',
  'godot_resource',
  'gdshader',
}

M.lsp = function() vim.lsp.enable 'gdscript' end

M.linters = {
  'gdtoolkit',
}

M.linters_by_ft = {
  gdscript = { 'gdlint' },
}

M.formatters = {
  'gdtoolkit',
}

M.formatters_by_ft = {
  gdscript = { 'gdformat' },
}

--- NOTE: From https://simondalvai.org/blog/godot-neovim/
---
--- @param client vim.lsp.Client
function M.init_nvim_server(client)
  local is_server_running = vim.uv.fs_stat(client.root_dir .. '/server.pipe')

  if not is_server_running then vim.fn.serverstart(client.root_dir .. '/server.pipe') end
end

return M
