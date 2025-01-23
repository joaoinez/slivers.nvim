---@type LazySpec
return {
  'stevearc/conform.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePost' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>cf',
      function() require('conform').format { async = true, lsp_format = 'fallback' } end,
      mode = '',
      desc = 'Format File',
    },
  },
  opts = function()
    return {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = LangSliver.get_ft_with_disabled_formatters()
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = LangSliver.get_formatters_by_ft(),
    }
  end,
}
