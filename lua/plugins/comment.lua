---@diagnostic disable: missing-fields

---@type LazySpec
return {
  'numToStr/Comment.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePost', 'VeryLazy' },
  config = function()
    require('Comment').setup {
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    }
  end,
}
