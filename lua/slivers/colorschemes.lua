local M = {}

local colorschemes = {
  catppuccin = {
    'catppuccin',
    'catppuccin-mocha',
    'catppuccin-macchiato',
    'catppuccin-latte',
    'catppuccin-frappe',
  },
  tokyonight = {
    'tokyonight',
    'tokyonight-night',
    'tokyonight-storm',
    'tokyonight-day',
    'tokyonight-moon',
  },
  ['rose-pine'] = {
    'rose-pine',
    'rose-pine-main',
    'rose-pine-moon',
    'rose-pine-dawn',
  },
}

local get_configs = function()
  local configs = {}

  for colorscheme, variants in pairs(colorschemes) do
    for _, variant in ipairs(variants) do
      configs[variant] = colorscheme
    end
  end

  return configs
end

M.configs = get_configs()

---@param palette table
---@param colors table
function M.load_colorscheme_hl(palette, colors)
  local hl_groups = {
    'SliversHarpoon',
    'SliversMacro',
    'SliversLsp',
    'SliversLazy',
    'SliversBreak',
    'SliversStop',
  }

  for i, hl_group in ipairs(hl_groups) do
    vim.api.nvim_set_hl(0, hl_group, { fg = palette[colors[i]] })
  end
end

-- Fallback
-- Cyan: Comment
--
--     Often used for comments in many color schemes, and the light cyan or teal colors often match this.
--
-- Purple: Statement
--
--     This group is commonly used for keywords like if, else, for, etc., and purple is often used for highlighting statements.
--
-- Pink: String
--
--     In many themes, strings are highlighted in a pink or magenta hue, so this would be the closest match.
--
-- Orange: Identifier
--
--     Identifiers, such as variable names, are often highlighted in orange or a similar warm color.
--
-- Red: Error
--
--     Red is most often associated with errors, warnings, or critical messages, so Error is a good match.
--
-- Yellow: WarningMsg
--
--     Yellow is typically used for warnings or attention-grabbing messages, and WarningMsg is the group for this.

local function load_catppuccin()
  local palette = require('catppuccin.palettes').get_palette(
    vim.g.colorscheme == 'catppuccin' and 'mocha' or vim.g.colorscheme:gsub('catppuccin%-', '')
  )

  vim.api.nvim_set_hl(0, 'SliversHarpoon', { fg = palette.sky })
  vim.api.nvim_set_hl(0, 'SliversMacro', { fg = palette.lavender })
  vim.api.nvim_set_hl(0, 'SliversLsp', { fg = palette.pink })
  vim.api.nvim_set_hl(0, 'SliversLazy', { fg = palette.peach })
  vim.api.nvim_set_hl(0, 'SliversBreak', { fg = palette.red })
  vim.api.nvim_set_hl(0, 'SliversStop', { fg = palette.yellow })
end

local function load_tokyonight()
  local palette = require('tokyonight.colors').setup()

  vim.api.nvim_set_hl(0, 'SliversHarpoon', { fg = palette.cyan })
  vim.api.nvim_set_hl(0, 'SliversMacro', { fg = palette.purple })
  vim.api.nvim_set_hl(0, 'SliversLsp', { fg = palette.magenta })
  vim.api.nvim_set_hl(0, 'SliversLazy', { fg = palette.orange })
  vim.api.nvim_set_hl(0, 'SliversBreak', { fg = palette.red })
  vim.api.nvim_set_hl(0, 'SliversStop', { fg = palette.yellow })
end

local function load_rose_pine()
  local palette = require 'rose-pine.palette'

  vim.api.nvim_set_hl(0, 'SliversHarpoon', { fg = palette.foam })
  vim.api.nvim_set_hl(0, 'SliversMacro', { fg = palette.iris })
  vim.api.nvim_set_hl(0, 'SliversLsp', { fg = palette.rose })
  vim.api.nvim_set_hl(0, 'SliversLazy', { fg = palette.pine })
  vim.api.nvim_set_hl(0, 'SliversBreak', { fg = palette.love })
  vim.api.nvim_set_hl(0, 'SliversStop', { fg = palette.gold })
end

local function has_colorscheme(tbl)
  for _, v in ipairs(tbl) do
    if v == vim.g.colorscheme then return true end
  end
  return false
end

function M.init()
  if has_colorscheme(colorschemes.catppuccin) then load_catppuccin() end
  if has_colorscheme(colorschemes.tokyonight) then load_tokyonight() end
  if has_colorscheme(colorschemes['rose-pine']) then load_rose_pine() end

  vim.cmd.colorscheme(vim.g.colorscheme)
end

return M
