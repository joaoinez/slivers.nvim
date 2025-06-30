---@diagnostic disable: missing-fields

---@type snacks.statuscolumn.Config
local M = {
  enabled = true,
  left = { 'git' }, -- priority of signs on the left (high to low)
  right = { 'mark', 'sign', 'fold' }, -- priority of signs on the right (high to low)
  folds = {
    open = true,
  },
}

return M
