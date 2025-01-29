---@class Slivers
---@field actions utils.actions
---@field autocmds utils.autocmds
---@field colorscheme utils.colorscheme
---@field keymaps utils.keymaps
---@field lazy utils.lazy
---@field lsp utils.lsp
---@field mason utils.mason
---@field misc utils.misc
local M = {
  actions = require 'slivers.utils.actions',
  autocmds = require 'slivers.utils.autocmds',
  colorscheme = require 'slivers.utils.colorscheme',
  keymaps = require 'slivers.utils.keymaps',
  lazy = require 'slivers.utils.lazy',
  lsp = require 'slivers.utils.lsp',
  mason = require 'slivers.utils.mason',
  misc = require 'slivers.utils.misc',
}

-- Load config after checking cache
---@param name "options" | "tabline" | "lazy" | "autocmds" | "keymaps" | "vscode"
function M.load(name)
  local function _load(mod)
    if name == 'options' or 'tabline' or 'lazy' then
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
