return {
  'MagicDuck/grug-far.nvim',
  enabled = true,
  event = 'VeryLazy',
  cmd = 'GrugFar',
  keys = {
    {
      '<leader>fr',
      function()
        require('grug-far').with_visual_selection {
          transient = true,
          prefills = { paths = vim.fn.expand '%' },
        }
      end,
      mode = { 'n', 'v' },
      desc = 'Find and Replace',
    },
    {
      '<leader>fR',
      function()
        local ext = vim.bo.buftype == '' and vim.fn.expand '%:e'

        require('grug-far').open {
          transient = true,
          prefills = {
            filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
          },
        }
      end,
      mode = { 'n', 'v' },
      desc = 'Find and Replace (project)',
    },
  },
  opts = { headerMaxWidth = 80 },
}
