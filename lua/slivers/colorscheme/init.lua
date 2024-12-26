local M = {}

M.colorschemes = require 'slivers.colorscheme.config'

function M.apply()
  -- [[ Apply Colorscheme ]]
  vim.cmd.colorscheme(vim.g.colorscheme)

  -- [[ Get Colorschemes Configs ]]
  local colorscheme = Slivers.colorscheme.get_config(M.colorschemes, vim.g.colorscheme)

  -- [[ Set Highlight Groups ]]
  vim.schedule(function() Slivers.colorscheme.set_hl_groups(colorscheme.hl_groups) end)
end

return M
