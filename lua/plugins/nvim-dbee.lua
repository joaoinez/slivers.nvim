---@type LazySpec
return {
  'kndndrj/nvim-dbee',
  enabled = true,
  cond = not vim.g.vscode,
  build = function() require('dbee').install() end,
  event = 'VeryLazy',
  keys = {
    {
      '<leader>l',
      function() require('dbee').toggle() end,
      desc = 'SQL Client (dbee)',
    },
  },
  config = function() require('dbee').setup() end,
}
