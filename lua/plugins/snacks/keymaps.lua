---@diagnostic disable: missing-fields

local M = {}

M.keys = {
  { '<leader>gg', function() require('snacks').lazygit() end, desc = 'Lazygit' },
  { '<leader>gf', function() require('snacks').lazygit.log_file() end, desc = 'Current File History' },
  { '<leader>gl', function() Snacks.lazygit.log() end, desc = 'Git Log (cwd)' },
  { '<leader>gB', function() require('snacks').gitbrowse() end, desc = 'Git Browse (github)' },
  {
    '<leader>N',
    desc = 'Neovim News',
    function()
      require('snacks').win {
        file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
        width = 0.6,
        height = 0.6,
        wo = {
          spell = false,
          wrap = false,
          signcolumn = 'yes',
          statuscolumn = ' ',
          conceallevel = 3,
        },
      }
    end,
  },
  { '<leader>tt', function() require('snacks').terminal() end, desc = 'Terminal (cwd)' },
  { '<leader>tz', function() require('snacks').zen() end, desc = 'Zen Mode' },
  { '<C-_>', function() require('snacks').terminal() end, desc = 'which_key_ignore' },
  { '<leader>.', function() Snacks.scratch() end, desc = 'Scratch Buffer' },
  { '<leader>S', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer' },
  {
    ']]',
    function() require('snacks').words.jump(vim.v.count1) end,
    desc = 'Next Reference (snacks)',
    mode = { 'n', 't' },
  },
  {
    '[[',
    function() require('snacks').words.jump(-vim.v.count1) end,
    desc = 'Prev Reference (snacks)',
    mode = { 'n', 't' },
  },
}

return M
