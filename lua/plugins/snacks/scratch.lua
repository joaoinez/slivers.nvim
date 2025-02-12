---@diagnostic disable: missing-fields

---@type snacks.scratch.Config
local M = {
  enabled = true,
  ft = function()
    -- if vim.bo.buftype == '' and vim.bo.filetype ~= '' then
    --   return vim.bo.filetype == 'lua' and vim.bo.filetype or 'markdown'
    -- end
    return 'markdown'
  end,
}

return M
