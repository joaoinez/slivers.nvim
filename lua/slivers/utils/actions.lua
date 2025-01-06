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

--- Convenient wapper to save code when we Trigger events.
--- To listen for an event triggered by this function you can use `autocmd`.
--- @param event string Name of the event.
--- @param is_urgent boolean|nil If true, trigger directly instead of scheduling. Useful for startup events.
-- @usage To run a User event:   `trigger_event("User MyUserEvent")`
-- @usage To run a Neovim event: `trigger_event("BufEnter")
function M.trigger_event(event, is_urgent)
  -- define behavior
  local function trigger()
    local is_user_event = string.match(event, '^User ') ~= nil
    if is_user_event then
      event = event:gsub('^User ', '')
      vim.api.nvim_exec_autocmds('User', { pattern = event, modeline = false })
    else
      vim.api.nvim_exec_autocmds(event, { modeline = false })
    end
  end

  -- execute
  if is_urgent then
    trigger()
  else
    vim.schedule(trigger)
  end
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
