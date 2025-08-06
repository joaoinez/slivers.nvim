local M = {}

M.highlighters = {
  'gdscript',
  'godot_resource',
  'gdshader',
}

M.linters = {
  'gdtoolkit',
}

M.linters_by_ft = {
  gdscript = { 'gdlint' },
}

M.formatters = {
  'gdtoolkit',
}

M.formatters_by_ft = {
  gdscript = { 'gdformat' },
}

return M
