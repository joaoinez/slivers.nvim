---@type LazySpec
return {
  'mistweaverco/kulala.nvim',
  enabled = true,
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
