---@type LazySpec
return {
  'NeogitOrg/neogit',
  enabled = true,
  cond = not vim.g.vscode,
  event = 'VeryLazy',
  keys = {
    {
      '<leader>gg',
      '<cmd>Neogit<cr>',
      desc = 'Neogit',
    },
    {
      '<leader>gc',
      '<cmd>Neogit commit<cr>',
      desc = 'Commit',
    },
    {
      '<leader>gp',
      '<cmd>Neogit pull<cr>',
      desc = 'Pull',
    },
    {
      '<leader>gP',
      '<cmd>Neogit push<cr>',
      desc = 'Push',
    },
    {
      '<leader>gZ',
      '<cmd>Neogit stash<cr>',
      desc = 'Stash',
    },
  },
  opts = {
    graph_style = 'kitty',
    signs = {
      hunk = { '', '' },
      item = { '', '' },
      section = { '', '' },
    },
    mappings = {
      commit_editor = {
        ['<cr>'] = 'Submit',
        ['<c-c><c-c>'] = 'Abort',
      },
      commit_editor_I = {
        ['<c-c><c-s>'] = 'Submit',
        ['<c-c><c-c>'] = 'Abort',
      },
      rebase_editor = {
        ['<c-c><c-s>'] = 'Submit',
        ['<c-c><c-c>'] = 'Abort',
        ['[c'] = 'OpenOrScrollUp',
        [']c'] = 'OpenOrScrollDown',
      },
      rebase_editor_I = {
        ['<c-c><c-s>'] = 'Submit',
        ['<c-c><c-c>'] = 'Abort',
      },
    },
  },
  init = function()
    Slivers.autocmds.autocmd('User', {
      group = Slivers.autocmds.augroup 'neogit_refresh',
      pattern = { 'NeogitPullComplete', 'NeogitBranchCheckout', 'NeogitStash' },
      callback = function()
        if vim.o.buftype ~= 'nofile' then vim.cmd 'checktime' end
      end,
    })
  end,
}
