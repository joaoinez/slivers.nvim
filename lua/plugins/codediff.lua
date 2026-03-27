-- NOTE: See https://github.com/esmuellert/codediff.nvim?tab=readme-ov-file#usage

---@type LazySpec
return {
  'esmuellert/codediff.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  event = 'VeryLazy',
  cmd = 'CodeDiff',
  keys = {
    {
      '<leader>gD',
      '<cmd>CodeDiff<cr>',
      desc = 'Diff (project)',
    },
    {
      '<leader>gl',
      '<cmd>CodeDiff history<cr>',
      desc = 'Log (codediff)',
    },
    {
      '<leader>gh',
      '<cmd>CodeDiff history %<cr>',
      desc = 'History (file)',
    },
  },
  opts = {
    keymaps = {
      view = {
        stage_hunk = '<leader>ga',
        unstage_hunk = '<leader>gu',
        discard_hunk = '<leader>gr',
      },
      conflict = {
        accept_incoming = '<leader>gXi',
        accept_current = '<leader>gXc',
        accept_both = '<leader>gXb',
        discard = '<leader>gXn',

        accept_all_incoming = '<leader>gXI',
        accept_all_current = '<leader>gXC',
        accept_all_both = '<leader>gXB',
        discard_all = '<leader>gXN',
      },
    },
  },
}
