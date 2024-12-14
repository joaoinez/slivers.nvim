---@diagnostic disable: missing-fields

local M = {}

M.keys = {
  { '<leader>gg', function() require('snacks').lazygit() end, desc = 'Lazygit' },
  { '<leader>gf', function() require('snacks').lazygit.log_file() end, desc = 'Current File History' },
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
  { '<C-_>', function() require('snacks').terminal() end, desc = 'which_key_ignore' },
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
