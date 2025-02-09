---@type LazySpec
return {
  'mfussenegger/nvim-lint',
  enabled = true,
  cond = not (vim.g.vscode or vim.g.server),
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'

    lint.linters_by_ft = LangSliver.get_linters_by_ft()

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        if vim.opt_local.modifiable:get() then lint.try_lint() end
      end,
    })
  end,
}
