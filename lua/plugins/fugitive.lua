---@type LazySpec
return {
  'tpope/vim-fugitive',
  enabled = true,
  cond = not vim.g.vscode,
  cmd = 'Git',
  keys = {
    {
      '<leader>gA',
      '<cmd>Git add %<cr>',
      desc = 'Stage (file)',
    },
    {
      '<leader>gU',
      '<cmd>Git restore --staged %<cr>',
      desc = 'Unstage (file)',
    },
  },
}
