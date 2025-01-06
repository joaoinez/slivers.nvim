local M = {
  name = 'kanagawa',
  variants = {
    'kanagawa-wave',
    'kanagawa-dragon',
    'kanagawa-lotus',
  },
  globals = {
    kanagawa_lualine_bold = true,
    -- HACK: See https://github.com/rebelot/kanagawa.nvim/issues/243
    trouble_lualine = false,
  },
}

return M
