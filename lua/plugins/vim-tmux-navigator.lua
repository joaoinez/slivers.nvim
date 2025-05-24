---@type LazySpec
return {
  'christoomey/vim-tmux-navigator',
  enabled = true,
  cond = not vim.g.vscode,
  lazy = false,
  cmd = {
    'TmuxNavigateLeft',
    'TmuxNavigateDown',
    'TmuxNavigateUp',
    'TmuxNavigateRight',
  },
  keys = {
    { '<C-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
    { '<C-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
    { '<C-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
    { '<C-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
  },
}
