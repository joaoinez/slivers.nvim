local M = {}

M.scaffolds = {
  require 'plugins.mini.files.scaffold.blazor',
}

function M.gen_scaffold_keymaps(buf_id)
  for _, scaffolds in ipairs(M.scaffolds) do
    for _, scaffold in pairs(scaffolds) do
      vim.keymap.set('n', 'gs' .. scaffold.key, scaffold.map, { buffer = buf_id, desc = scaffold.desc })
    end
  end
end

return M
