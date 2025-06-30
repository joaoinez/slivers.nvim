local M = {}

---@param opts? snacks.layout
---@param preview_width? number
---@return snacks.layout.Box
M.default = function(opts, preview_width)
  return vim.tbl_deep_extend('force', {
    layout = {
      box = 'horizontal',
      width = 0.8,
      min_width = 120,
      height = 0.8,
      {
        box = 'vertical',
        border = 'rounded',
        title = '{title} {live} {flags}',
        { win = 'input', height = 1, border = 'bottom' },
        { win = 'list', border = 'none' },
      },
      { win = 'preview', title = '{preview}', border = 'rounded', width = preview_width or 0.5 },
    },
  }, opts or {})
end

---@param opts? snacks.layout
---@param preview_height? number
---@return snacks.layout.Box
M.dropdown = function(opts, preview_height)
  return vim.tbl_deep_extend('force', {
    layout = {
      backdrop = false,
      row = 1,
      width = 0.4,
      min_width = 80,
      height = 0.8,
      border = 'none',
      box = 'vertical',
      {
        win = 'preview',
        title = '{preview}',
        height = preview_height or 0.4,
        border = 'rounded',
      },
      {
        box = 'vertical',
        border = 'rounded',
        title = '{title} {live} {flags}',
        title_pos = 'center',
        { win = 'input', height = 1, border = 'bottom' },
        { win = 'list', border = 'none' },
      },
    },
  }, opts or {})
end

return M
