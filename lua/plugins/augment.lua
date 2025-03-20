---@type LazySpec
return {
  'augmentcode/augment.vim',
  enabled = false,
  cond = not vim.g.vscode,
  event = 'VeryLazy',
  config = function() vim.g.augment_workspace_folders = { '~/Projects/' } end,
}
