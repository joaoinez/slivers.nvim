---@type LazySpec
return {
  'folke/flash.nvim',
  enabled = true,
  event = 'VeryLazy',
  keys = {
    {
      's',
      mode = { 'n', 'x' },
      function() require('flash').jump() end,
      desc = 'Flash',
    },
    {
      'mt',
      mode = { 'n', 'x' },
      function() require('flash').treesitter() end,
      desc = 'Select Treesitter Block',
    },
    {
      'r',
      mode = 'o',
      function() require('flash').jump() end,
      desc = 'Remote',
    },
    {
      'm',
      mode = 'o',
      function() require('flash').treesitter() end,
      desc = 'Matching Block',
    },
  },
  opts = {},
}
