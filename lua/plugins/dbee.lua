---@type LazySpec
return {
  'kndndrj/nvim-dbee',
  enabled = true,
  cond = not vim.g.vscode,
  build = function() require('dbee').install() end,
  event = 'VeryLazy',
  keys = {
    {
      '<leader>kd',
      function() require('dbee').toggle() end,
      desc = 'DBee',
    },
  },
  config = function() require('dbee').setup() end,
}
