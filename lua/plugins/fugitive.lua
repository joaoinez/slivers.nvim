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
      desc = 'Add file',
    },
  },
}
