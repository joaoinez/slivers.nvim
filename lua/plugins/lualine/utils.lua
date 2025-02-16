local M = {}

function M.get_harpoon_indicator(prefix, suffix)
  return function(harpoon_entry)
    local path = {}
    local i = 1
    local matched = harpoon_entry.value:gmatch '([^/]+)'

    if not matched then return 'unknown' end

    for value in matched do
      path[i] = value and value or ''
      i = i + 1
    end

    local trimmed_filename = #path > 1 and path[#path - 1] .. '/' .. path[#path] or path[1]

    return (prefix or '') .. trimmed_filename .. (suffix or '')
  end
end

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
