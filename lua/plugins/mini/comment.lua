---@type LazySpec
return {
  'nvim-mini/mini.comment',
  enabled = false,
  cond = not vim.g.vscode,
  version = false,
  event = 'VeryLazy',
  opts = {
    options = {
      custom_commentstring = function()
        if vim.bo.filetype == 'razor' then return '@* %s *@' end
        return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
      end,
    },
  },
}
