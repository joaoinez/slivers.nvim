return {
  ---@type LazySpec
  {
    dir = '~/Documents/Projects/arco-iris.nvim',
    enabled = vim.g.dev,
    cond = not vim.g.vscode,
    priority = 1001,
    lazy = false,
    keys = {
      {
        '<leader>,c',
        '<cmd>Caipirinha pick<cr>',
        desc = 'Colorschemes',
      },
    },
    opts = {
      callback = function() ColorSliver() end,
    },
  },
}
