---@diagnostic disable: missing-fields

local M = {
  { '<leader>ao', function() require('snacks').terminal 'oterm' end, desc = 'Ollama' },
  {
    '<leader>ag',
    function()
      require('snacks').terminal "aider --commit; echo -e '\\nPress 'q' to quit.'; while true; do read -n1 -s key; [[ $key == 'q' ]] && { echo; exit 0; }; done"
    end,
    desc = 'Git Commit',
  },
  { '<leader>gg', function() require('snacks').lazygit() end, desc = 'Lazygit' },
  { '<leader>gf', function() require('snacks').lazygit.log_file() end, desc = 'Current File History' },
  { '<leader>gl', function() Snacks.lazygit.log() end, desc = 'Git Log (cwd)' },
  { '<leader>gB', function() require('snacks').gitbrowse() end, desc = 'Git Browse (github)' },
  {
    '<leader>,n',
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
  {
    '<leader>tt',
    function()
      local git_root = Snacks.git.get_root()
      require('snacks').terminal(nil, { cwd = git_root })
    end,
    desc = 'Terminal',
  },
  {
    '<leader>tC',
    function()
      local current_dir = vim.fn.expand '%:p:h'
      if current_dir == '' or vim.fn.isdirectory(current_dir) == 0 then current_dir = vim.fn.getcwd() end
      require('snacks').terminal(nil, { cwd = current_dir })
    end,
    desc = 'Terminal (cwd)',
  },
  {
    '<C-/>',
    function()
      local git_root = Snacks.git.get_root()
      require('snacks').terminal(nil, { cwd = git_root })
    end,
    desc = 'Terminal',
  },
  {
    '<C-_>',
    function()
      local git_root = Snacks.git.get_root()
      require('snacks').terminal(nil, { cwd = git_root })
    end,
    desc = 'which_key_ignore',
  },
  { '<leader>tz', function() require('snacks').zen() end, desc = 'Zen Mode' },
  { '<leader>.', function() Snacks.scratch() end, desc = 'Scratch Buffer' },
  {
    ']]',
    function() require('snacks').words.jump(vim.v.count1) end,
    desc = 'Next Reference (snacks)',
    mode = { 'n' },
  },
  {
    '[[',
    function() require('snacks').words.jump(-vim.v.count1) end,
    desc = 'Prev Reference (snacks)',
    mode = { 'n' },
  },
}

return M
