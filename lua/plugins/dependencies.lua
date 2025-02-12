---@type LazySpec
return {
  -- Core
  {
    'nvim-lua/plenary.nvim',
    enabled = true,
    lazy = true,
  },
  -- UI
  {
    'MunifTanjim/nui.nvim',
    enabled = true,
    cond = not vim.g.vscode,
    lazy = true,
  },
  {
    'nvzone/volt',
    enabled = true,
    cond = not vim.g.vscode,
    lazy = true,
  },
  -- Icons
  {
    'nvim-tree/nvim-web-devicons',
    enabled = true,
    cond = not vim.g.vscode,
    lazy = true,
  },
}
