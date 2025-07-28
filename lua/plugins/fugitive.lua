---@type LazySpec
return {
  'tpope/vim-fugitive',
  enabled = true,
  cond = not vim.g.vscode,
  cmd = 'Git',
  keys = {
    {
      '<leader>g.',
      '<cmd>Git add .<cr>',
      desc = 'Stage (all)',
    },
    {
      '<leader>g,',
      '<cmd>Git restore --staged .<cr>',
      desc = 'Unstage (all)',
    },
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
    {
      '<leader>gf',
      '<cmd>Git fetch<cr>',
      desc = 'Fetch',
    },
  },
}
