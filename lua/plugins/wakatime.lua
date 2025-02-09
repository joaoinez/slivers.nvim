return {
  'wakatime/vim-wakatime',
  enabled = not vim.g.dev,
  cond = not vim.g.vscode,
  lazy = false,
}
