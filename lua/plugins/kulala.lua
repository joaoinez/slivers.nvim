---@type LazySpec
return {
  'mistweaverco/kulala.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  event = 'VeryLazy',
  opts = {
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
