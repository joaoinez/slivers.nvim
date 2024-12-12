---@diagnostic disable: duplicate-doc-field

---@class utils.lsp
local M = {}

--- Check if lsp client supports a certain method
--- @param client vim.lsp.Client|nil The client where the lsp mappings will load.
function M.supports(client)
  --- @param method string The name of the method
  return function(method) return client and client.supports_method(vim.lsp.protocol.Methods[method]) end
end

M.action = setmetatable({}, {
  __index = function(_, action)
    return function()
      vim.lsp.buf.code_action {
        apply = true,
        context = {
          only = { action },
          diagnostics = {},
        },
      }
    end
  end,
})

---@class LspCommand: lsp.ExecuteCommandParams
---@field open? boolean
---@field handler? lsp.Handler
---@param opts LspCommand
function M.execute(opts)
  local params = {
    command = opts.command,
    arguments = opts.arguments,
  }
  if opts.open then
    require('trouble').open {
      mode = 'lsp_command',
      params = params,
    }
  else
    return vim.lsp.buf_request(0, 'workspace/executeCommand', params, opts.handler)
  end
end

return M
