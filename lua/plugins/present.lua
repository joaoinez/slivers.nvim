---@type LazySpec
return {
  'joaoinez/present.nvim',
  enabled = true,
  event = 'VeryLazy',
  cmd = { 'PresentStart' },
  keys = {
    { '<leader>kP', '<cmd>PresentStart<cr>', desc = 'Present Markdown File' },
  },
  opts = {},
}
