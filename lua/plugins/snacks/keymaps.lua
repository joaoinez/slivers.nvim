---@diagnostic disable: missing-fields

local M = {
  { '<leader>ao', function() require('snacks').terminal 'oterm' end, desc = 'Ollama' },
  {
    '<leader>ag',
    function()
      local command =
        'git add . && aider --commit; printf \'\\nPress q to quit.\'; old_stty=$(stty -g); stty raw -echo; key=$(dd bs=1 count=1 2>/dev/null); stty "$old_stty"; [ "$key" = \'q\' ] && exit 0'
      require('snacks').terminal(command)
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
  },
  {
    '[[',
    function() require('snacks').words.jump(-vim.v.count1) end,
    desc = 'Previous Reference (snacks)',
  },
}

return M
