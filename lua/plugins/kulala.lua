---@type LazySpec
return {
  'mistweaverco/kulala.nvim',
  enabled = false,
  cond = not vim.g.vscode,
  ft = 'http',
  event = 'VeryLazy',
  opts = {
    default_view = 'verbose',
    icons = {
      inlay = {
        loading = '⏳',
        done = '✅',
        error = '❌',
      },
      lualine = '🐼',
    },
  },
}
