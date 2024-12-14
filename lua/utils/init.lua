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
  actions = require 'utils.actions',
  autocmds = require 'utils.autocmds',
  keymaps = require 'utils.keymaps',
  lazy = require 'utils.lazy',
  lsp = require 'utils.lsp',
  mason = require 'utils.mason',
  mini = require 'utils.mini',
  misc = require 'utils.misc',
}

return M
