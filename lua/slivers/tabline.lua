function _G.TablineSliver()
  local tabs = vim.api.nvim_list_tabpages()
  if #tabs == 0 then return '' end

  local current_tab = vim.api.nvim_get_current_tabpage()
  local tabline_components = {}

  for i, tab_id in ipairs(tabs) do
    local is_active = (tab_id == current_tab)
    local tab_number = i

    local win = vim.api.nvim_tabpage_get_win(tab_id)
    local buf = vim.api.nvim_win_get_buf(win)
    local buf_name = vim.api.nvim_buf_get_name(buf)
    local tab_name = buf_name ~= '' and vim.fn.fnamemodify(buf_name, ':t') or '[No Name]'

    tab_name = (#tab_name > 15) and (tab_name:sub(1, 12) .. '...') or tab_name

    _G['close_tab_' .. tab_id] = function() vim.api.nvim_command('tabclose ' .. tab_id) end

    local component = string.format('%%%dT', tab_number)
    component = component .. (is_active and '%#TabLineSel#' or '%#TabLine#')
    component = component .. ' ' .. tab_number .. ' ' .. tab_name .. ' '
    component = component .. '%T'

    component = component .. string.format('%%@v:lua.close_tab_%d@×%%X ', tab_id)

    table.insert(tabline_components, component)
  end

  -- Right-align remaining space
  return table.concat(tabline_components, '') .. '%#TabLineFill#%=%T'
end

-- Enable the custom tabline
vim.o.tabline = '%!v:lua.TablineSliver()'
