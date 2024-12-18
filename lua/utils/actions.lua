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
