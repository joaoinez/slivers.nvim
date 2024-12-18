---@type LazySpec
return {
  'windwp/nvim-ts-autotag',
  enabled = true,
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePost' },
  opts = {},
}
