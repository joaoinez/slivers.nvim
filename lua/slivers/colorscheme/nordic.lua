local M = {
  name = 'nordic',
  globals = function()
    local lualine_borders = vim.g.lualine_borders
    local trouble_lualine = vim.g.trouble_lualine

    if vim.g.transparent_bg then
      lualine_borders = false
      trouble_lualine = false
    end

    return {
      lualine_borders = lualine_borders,
      trouble_lualine = trouble_lualine,
    }
  end,
}

return M
