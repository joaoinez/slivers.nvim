---@class utils.colorscheme
local M = {}

---@param colorschemes_configs table
function M.get_config(colorschemes_configs, colorscheme_name)
  local colorscheme_config = nil

  for name, config in pairs(colorschemes_configs) do
    if colorscheme_config ~= nil then break end

    if colorscheme_name == name then
      colorscheme_config = config
      break
    end

    if config.variants then
      for _, variant in ipairs(config.variants) do
        if colorscheme_name == variant then
          colorscheme_config = config
          break
        end
      end
    end
  end

  if colorscheme_config == nil then colorscheme_config = colorschemes_configs._fallback end

  return colorscheme_config
end

---@param colorscheme_hl_groups table
function M.set_hl_groups(colorscheme_hl_groups)
  for hl_group, hl_config in
    pairs(type(colorscheme_hl_groups) == 'function' and colorscheme_hl_groups() or colorscheme_hl_groups)
  do
    vim.api.nvim_set_hl(0, 'Slivers' .. hl_group, hl_config)
  end
end

return M
