---@type LazySpec
return {
  'folke/flash.nvim',
  enabled = true,
  event = 'VeryLazy',
  keys = {
    {
      's',
      mode = { 'n', 'x', 'o' },
      function() require('flash').jump() end,
      desc = 'Flash',
    },
    {
      'mt',
      mode = { 'n', 'o', 'x' },
      function() require('flash').treesitter() end,
      desc = 'Flash Treesitter',
    },
  },
  opts = {},
}
