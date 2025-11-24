---@type LazySpec
return {
  'Mofiqul/vscode.nvim',
  enabled = true,
  priority = 1000,
  lazy = Slivers.colorscheme.get_config(ColorSliver.colorschemes, vim.g.colors_name).name ~= 'vscode',
  opts = {
    transparent = vim.g.transparent_bg,
  },
}
