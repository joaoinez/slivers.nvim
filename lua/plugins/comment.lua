---@diagnostic disable: missing-fields, return-type-mismatch

---@type LazySpec
return {
  'numToStr/Comment.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePost', 'VeryLazy' },
  config = function()
    local ts_context_commentstring = require 'ts_context_commentstring.integrations.comment_nvim'
    require('Comment').setup {
      pre_hook = function(ctx)
        -- HACK: for some reason changing the `JoosepAlviste/nvim-ts-context-commentstring`
        -- plugin doesn't work, so this will do
        if vim.bo.filetype == 'razor' then return '@* %s *@' end

        return ts_context_commentstring.create_pre_hook()(ctx)
      end,
    }
  end,
}
