---@class utils.colorscheme
local M = {}

M.default_colorschemes = {
  'blue',
  'darkblue',
  'default',
  'delek',
  'desert',
  'elflord',
  'evening',
  'habamax',
  'industry',
  'koehler',
  'lunaperche',
  'morning',
  'murphy',
  'pablo',
  'peachpuff',
  'quiet',
  'retrobox',
  'ron',
  'shine',
  'slate',
  'sorbet',
  'torte',
  'unokai',
  'vim',
  'wildcharm',
  'zaibatsu',
  'zellner',
}

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

---@return string[]
function M.get_installed_colorschemes()
  local colors = vim.fn.getcompletion('', 'color')

  local filtered_colors = {}
  for _, color in ipairs(colors) do
    local is_default = false
    for _, default_color in ipairs(M.default_colorschemes) do
      if color == default_color then
        is_default = true
        break
      end
    end
    if not is_default then table.insert(filtered_colors, color) end
  end
  colors = filtered_colors

  local lazy = package.loaded['lazy.core.util']
  if lazy and lazy.get_unloaded_rtp then
    local paths = lazy.get_unloaded_rtp ''
    local all_files =
      ---@diagnostic disable-next-line: param-type-mismatch
      vim.fn.globpath(table.concat(paths, ','), 'colors/*', 1, 1)
    for _, f in ipairs(all_files) do
      table.insert(colors, vim.fn.fnamemodify(f, ':t:r'))
    end
  end

  for i, color in ipairs(colors) do
    if color == vim.g.colors_name then
      table.remove(colors, i)
      table.insert(colors, 1, color)
      break
    end
  end

  return colors
end

---@param colorscheme_hl_groups table|nil
function M.set_hl_groups(colorscheme_hl_groups)
  for hl_group, hl_config in
    pairs(
      type(colorscheme_hl_groups) == 'function' and colorscheme_hl_groups()
        or colorscheme_hl_groups
        or ColorSliver.colorschemes._fallback.hl_groups()
    )
  do
    vim.api.nvim_set_hl(0, 'Slivers' .. hl_group, hl_config)
  end
end

---@param colorscheme_globals table|nil
function M.set_globals(colorscheme_globals)
  for global, value in
    pairs(type(colorscheme_globals) == 'function' and colorscheme_globals() or colorscheme_globals or {})
  do
    vim.g[global] = value
  end
end

return M
