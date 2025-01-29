---@type LazySpec
return {
  'NeogitOrg/neogit',
  enabled = true,
  cond = not vim.g.vscode,
  event = 'VeryLazy',
  keys = {
    {
      '<leader>gs',
      '<cmd>Neogit<cr>',
      desc = 'Status',
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
      '<leader>gS',
      '<cmd>Neogit stash<cr>',
      desc = 'Stash',
    },
    {
      '<leader>gl',
      '<cmd>Neogit log<cr>',
      desc = 'Log (project)',
    },
    {
      '<leader>gf',
      '<cmd>NeogitLogCurrent<cr>',
      desc = 'Log (file)',
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
}
