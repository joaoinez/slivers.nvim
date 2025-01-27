---@diagnostic disable: missing-fields

local M = {
  { '<leader>ao', function() require('snacks').terminal 'oterm' end, desc = 'Ollama' },
  {
    '<leader>gc',
    function()
      local command = [[
bash -c '
git add . && aider --commit || exit 1
while true; do
  read -n 1 -s -p "Press \"q\" to quit or \"p\" to push: " key
  printf "\n"
  case "$key" in
    q) echo "Quitting without pushing"; exit 0;;
    p) git push
       while true; do
         read -n 1 -s -p "Push completed. Press \"q\" to quit: " key
         printf "\n"
         [ "$key" = "q" ] && exit 0
       done
       ;;
    *) echo "Invalid option";;
  esac
done
']]
      require('snacks').terminal(command)
    end,
    desc = 'Git Commit (ai)',
  },
  { '<leader>gg', function() require('snacks').lazygit() end, desc = 'Lazygit' },
  { '<leader>gf', function() require('snacks').lazygit.log_file() end, desc = 'Current File History' },
  { '<leader>gl', function() require('snacks').lazygit.log() end, desc = 'Git Log (cwd)' },
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
      local git_root = require('snacks').git.get_root()
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
      local git_root = require('snacks').git.get_root()
      require('snacks').terminal(nil, { cwd = git_root })
    end,
    desc = 'Terminal',
  },
  {
    '<C-_>',
    function()
      local git_root = require('snacks').git.get_root()
      require('snacks').terminal(nil, { cwd = git_root })
    end,
    desc = 'which_key_ignore',
  },
  { '<leader>tz', function() require('snacks').zen() end, desc = 'Zen Mode' },
  { '<leader>.', function() require('snacks').scratch() end, desc = 'Scratch Buffer' },
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
