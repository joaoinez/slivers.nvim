---@type LazySpec
return {
  'oribarilan/lensline.nvim',
  enabled = false,
  -- cond = not vim.g.vscode,
  branch = 'release/1.x',
  event = 'LspAttach',
  opts = {},
}
