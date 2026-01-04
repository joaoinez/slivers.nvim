---@type LazySpec
return {
  'MagicDuck/grug-far.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  event = 'VeryLazy',
  cmd = { 'GrugFar' },
  keys = {
    {
      '<leader>frw',
      function()
        require('grug-far').open { prefills = { search = vim.fn.expand '<cword>', paths = vim.fn.expand '%' } }
      end,
      mode = { 'n' },
      desc = 'Word',
    },
    {
      '<leader>frf',
      function() require('grug-far').open { prefills = { search = '', paths = vim.fn.expand '%' } } end,
      mode = { 'n' },
      desc = 'File',
    },
    {
      '<leader>frp',
      function()
        local ext = vim.bo.buftype == '' and vim.fn.expand '%:e'
        require('grug-far').open { prefills = { search = '', filesFilter = ext and ext ~= '' and '*.' .. ext or nil } }
      end,
      mode = { 'n' },
      desc = 'Project',
    },
    {
      '<leader>frf',
      function() require('grug-far').with_visual_selection { prefills = { paths = vim.fn.expand '%' } } end,
      mode = { 'v' },
      desc = 'File',
    },
    {
      '<leader>frp',
      function()
        local ext = vim.bo.buftype == '' and vim.fn.expand '%:e'
        require('grug-far').with_visual_selection {
          prefills = { filesFilter = ext and ext ~= '' and '*.' .. ext or nil },
        }
      end,
      mode = { 'v' },
      desc = 'Project',
    },
  },
  opts = { headerMaxWidth = 80 },
}
