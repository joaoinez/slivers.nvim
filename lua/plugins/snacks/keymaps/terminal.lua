local M = {
  {
    '<leader>tt',
    function()
      local git_root = Snacks.git.get_root()
      Snacks.terminal(nil, { cwd = git_root, win = { height = 0.3 } })
    end,
    desc = 'Terminal',
  },
  {
    '<leader>t.',
    function()
      local current_dir = vim.fn.expand '%:p:h'
      if current_dir == '' or vim.fn.isdirectory(current_dir) == 0 then current_dir = vim.fn.getcwd() end
      Snacks.terminal(nil, { cwd = current_dir, win = { height = 0.3 } })
    end,
    desc = 'Terminal (cwd)',
  },
  {
    '<C-/>',
    function()
      local git_root = Snacks.git.get_root()
      Snacks.terminal(nil, { cwd = git_root, win = { height = 0.3 } })
    end,
    desc = 'Terminal',
  },
  {
    '<C-_>',
    function()
      local git_root = Snacks.git.get_root()
      Snacks.terminal(nil, { cwd = git_root, win = { height = 0.3 } })
    end,
    desc = 'which_key_ignore',
  },
}

return M
