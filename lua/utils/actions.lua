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

local find_files = function()
  local result = vim.fn.systemlist("find . -type f | fzf")

  if #result > 0 then
    vim.cmd("edit " .. result[1])
  end
end

local live_grep = function()
  local text = vim.fn.input("Search for: ")
  if text ~= "" then
    vim.cmd("grep " .. text .. " *")
    vim.cmd("copen")
  end
end

function FindFile()
  local result = vim.fn.systemlist("fd --type f")
  if #result > 0 then
    local choice = vim.fn.inputlist(result)
    if choice > 0 and choice <= #result then
      vim.cmd("edit " .. result[choice])
    end
  end
end

function GrepText()
  local search_text = vim.fn.input("Search for: ")
  if search_text ~= "" then
    if 1 == vim.fn.executable 'rg' then
      local result = vim.fn.systemlist("rg --vimgrep " .. vim.fn.shellescape(search_text))
    end
    if #result > 0 then
      vim.fn.setqflist({}, 'r', { title = 'Search Results', lines = result })
      vim.cmd("copen")
    else
      print("No matches found!")
    end
  end
end

-- if 1 == vim.fn.executable 'rg' then
--   return { 'rg', '--files', '--color', 'never', '-g', '!.git' }
-- elseif 1 == vim.fn.executable 'fd' then
--   return { 'fd', '--type', 'f', '--color', 'never', '-E', '.git' }
-- elseif 1 == vim.fn.executable 'fdfind' then
--   return { 'fdfind', '--type', 'f', '--color', 'never', '-E', '.git' }
-- elseif 1 == vim.fn.executable 'find' and vim.fn.has 'win32' == 0 then
--   return { 'find', '.', '-type', 'f' }
-- elseif 1 == vim.fn.executable 'where' then
--   return { 'where', '/r', '.', '*' }

-- Used to pick something
---@param cmd? string
function M.pick(cmd, opts)
  cmd = cmd or "files"
  local try = {
    function() return require("telescope.builtin")[cmd == "files" and "find_files" or cmd](opts) end,
    function()
      return nil
    end
  }
  for _, fn in ipairs(try) do
    if pcall(fn) then
      return
    end
  end
end

-- Used to view files
function M.explore()
  local try = {
    function() return vim.api.nvim_command('Oil') end,
    function() return vim.api.nvim_command('Explore') end,
  }
  for _, fn in ipairs(try) do
    if pcall(fn) then
      return
    end
  end
end

-- TODO:
-- url
-- enabled
-- version
-- branch
-- name
-- dependencies
-- build
-- main
-- priority
-- lazy
-- ft
-- event
-- cmd
-- keys
-- init
-- opts
-- config

return M
