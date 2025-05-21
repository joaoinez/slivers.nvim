local M = {
  {
    '<leader>gb',
    function()
      Snacks.picker.git_branches {
        layout = 'vscode',
        win = { input = { footer = '┤ <c-a> add │ <c-x> delete ├ ', footer_pos = 'center' } },
      }
    end,
    desc = 'Git Branches',
  },
  {
    '<leader>gs',
    function()
      Snacks.picker.git_status {
        win = {
          input = {
            footer = '┤ <tab> (un)stage │ <c-g> git │ <c-c> commit ├ ',
            footer_pos = 'right',
            keys = {
              ['<c-g>'] = {
                'neogit_open',
                mode = { 'n', 'i' },
              },
              ['<c-c>'] = {
                'neogit_commit',
                mode = { 'n', 'i' },
              },
            },
          },
        },
        actions = {
          neogit_open = function() require('neogit').open() end,
          neogit_commit = function(picker)
            require('neogit').open { 'commit' }
            picker:close()
          end,
        },
      }
    end,
    desc = 'Git Status',
  },
  {
    '<leader>gl',
    function() Snacks.picker.git_log() end,
    desc = 'Log',
  },
  {
    '<leader>gh',
    function() Snacks.picker.git_log_file() end,
    desc = 'History (file)',
  },
  {
    '<leader>g/',
    function() Snacks.terminal('git hook run pre-commit', { auto_close = false, win = { border = 'rounded' } }) end,
    desc = 'Run `pre-commit` hook',
  },
  {
    '<leader>gC',
    function()
      local command = [[
bash -c '
aider --commit --weak-model groq/llama-3.3-70b-versatile || exit 1
while true; do
  read -n 1 -s -p "Press \"q\" to quit or \"P\" to push: " key
  printf "\n"
  case "$key" in
    q) echo "Quitting without pushing"; exit 0;;
    P) git push
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

      vim.cmd 'w'
      Snacks.terminal(command, { win = { border = 'rounded' } })
    end,
    desc = 'Commit (aider)',
  },
  { '<leader>gG', function() Snacks.lazygit() end, desc = 'Lazygit' },
  { '<leader>gB', function() Snacks.gitbrowse() end, desc = 'Browse Repo (github)' },
  {
    '<leader>go',
    function() Snacks.terminal('gh pr create', { win = { border = 'rounded' } }) end,
    desc = 'Open PR (github)',
  },
}

return M
