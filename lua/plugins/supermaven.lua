---@type LazySpec
return {
  'supermaven-inc/supermaven-nvim',
  enabled = true,
  cond = not vim.g.vscode,
  event = 'InsertEnter',
  opts = {},
}
