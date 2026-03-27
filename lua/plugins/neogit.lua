---@type LazySpec
return {
  'NeogitOrg/neogit',
  enabled = true,
  cond = not vim.g.vscode,
  dependencies = {
    'sindrets/diffview.nvim',
  },
  event = 'VeryLazy',
  cmd = 'Neogit',
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
      '<leader>gP',
      '<cmd>Neogit push<cr>',
      desc = 'Push',
    },
    {
      '<leader>gZ',
      '<cmd>Neogit stash<cr>',
      desc = 'Stash',
    },
    {
      '<leader>gL',
      '<cmd>Neogit log<cr>',
      desc = 'Log (neogit)',
    },
  },
  opts = {
    graph_style = 'kitty',
    remember_settings = false,
    use_per_project_settings = false,
    diff_viewer = 'diffview',
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
      pattern = {
        'NeogitStatusRefreshed',
        'NeogitPullComplete',
        'NeogitBranchCheckout',
        'NeogitStash',
      },
      callback = function()
        if vim.o.buftype ~= 'nofile' then vim.cmd 'set autoread | checktime' end
      end,
    })
  end,
}
