return {
  'wakatime/vim-wakatime',
  enabled = not vim.g.server,
  cond = not vim.g.vscode,
  lazy = false,
}
