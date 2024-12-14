---@class utils.actions
local M = {}

local function bool2str(bool) return bool and 'on' or 'off' end

--- Sends a notification with 'Neovim' as default title.
--- Same as using vim.notify, but it saves us typing the title every time.
--- @param msg string The notification body.
--- @param type number|nil The type of the notification (:help vim.log.levels).
--- @param opts? table The nvim-notify options to use (:help notify-options).
function M.notify(msg, type, opts)
  vim.schedule(function() vim.notify(msg, type, vim.tbl_deep_extend('force', { title = 'Neovim' }, opts or {})) end)
end

--- Toggle diagnostics
function M.toggle_diagnostics()
  local state = not vim.g.diagnostics_enabled

  vim.g.diagnostics_enabled = state

  if state then
    local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
    local diagnostic_signs = {}

    for type, icon in pairs(signs) do
      diagnostic_signs[vim.diagnostic.severity[type]] = icon
    end

    vim.diagnostic.config {
      signs = { text = diagnostic_signs },
      virtual_text = {
        spacing = 4,
        source = 'if_many',
        prefix = '●',
      },
    }
  else
    vim.diagnostic.config { underline = false, virtual_text = false, signs = false, update_in_insert = false }
  end

  M.notify(string.format('Diagnostics turned %s', bool2str(vim.g.diagnostics_enabled)))
end

-- Used to view files
function M.explore()
  local try = {
    function() return vim.api.nvim_command 'Oil' end,
    function() return vim.api.nvim_command 'Explore' end,
  }
  for _, fn in ipairs(try) do
    if pcall(fn) then return end
  end
end

return M
