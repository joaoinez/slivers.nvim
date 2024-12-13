return {
  'stevearc/conform.nvim',
  enabled = false,
  event = 'User LazyFile',
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>cf',
      function() require('conform').format { async = true, lsp_format = 'fallback' } end,
      mode = '',
      desc = 'Format Buffer',
    },
  },
  opts = function()
    local lang = require 'config.lang'

    return {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = lang.get_ft_with_disabled_formatters()
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
      formatters_by_ft = lang.get_formatters_by_ft(),
    }
  end,
}
