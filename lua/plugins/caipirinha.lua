---@type LazySpec
return {
  'joaoinez/caipirinha.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  priority = 1001,
  lazy = false,
  keys = {
    {
      '<leader>,c',
      function() require('caipirinha').pick_colorscheme {} end,
      desc = 'Choose Colorscheme',
    },
  },
  opts = {
    callback = function() ColorSliver.apply() end,
  },
}
