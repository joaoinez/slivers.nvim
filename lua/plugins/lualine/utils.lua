local M = {}

function M.get_color(hl_name)
  local success, color = pcall(
    function() return string.format('#%06x', vim.api.nvim_get_hl(0, { name = 'Slivers' .. hl_name }).fg) end
  )

  if not success then return {} end

  return {
    fg = color,
  }
end

return M
