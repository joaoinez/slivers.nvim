---@diagnostic disable: unused-local

-- [[ Example Language Config ]]

local M = {}

M.highlighters = {}

M.servers = {}

M.formatters = {}

M.formatters_by_ft = {}

M.linters = {}

M.linters_by_ft = {}

M.debuggers = {}

---@param dap table
function M.dap_adapters(dap) end

M.dap_filetypes = {}

---@param dap table
function M.dap_configurations(dap) end

return M
