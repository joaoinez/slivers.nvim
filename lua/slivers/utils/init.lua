---@class Slivers
---@field actions utils.actions
---@field autocmds utils.autocmds
---@field keymaps utils.keymaps
---@field lazy utils.lazy
---@field lsp utils.lsp
---@field mason utils.mason
---@field mini utils.mini
---@field misc utils.misc
local M = {
  actions = require 'slivers.utils.actions',
  autocmds = require 'slivers.utils.autocmds',
  keymaps = require 'slivers.utils.keymaps',
  lazy = require 'slivers.utils.lazy',
  lsp = require 'slivers.utils.lsp',
  mason = require 'slivers.utils.mason',
  mini = require 'slivers.utils.mini',
  misc = require 'slivers.utils.misc',
}

-- Load config after checking cache
---@param name "autocmds" | "options" | "keymaps"
function M.load(name)
  local function _load(mod)
    if name == 'options' then
      require(mod)
    elseif require('lazy.core.cache').find(mod)[1] then
      require('lazy.core.util').try(function() require(mod) end, { msg = 'Failed loading ' .. mod })
    end
  end

  local pattern = 'LazySlivers' .. name:sub(1, 1):upper() .. name:sub(2)

  _load('slivers.' .. name)

  if vim.bo.filetype == 'lazy' then
    -- HACK: LazySlivers may have overwritten options of the Lazy ui, so reset this here
    vim.cmd [[do VimResized]]
  end
  vim.api.nvim_exec_autocmds('User', { pattern = pattern, modeline = false })
end

return M
