---@type LazySpec
return {
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  enabled = false,
  cond = not vim.g.vscode,
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePost', 'VeryLazy' },
  keys = {
    {
      '<leader>tl',
      function() require('lsp_lines').toggle() end,
      { desc = 'Toggle LSP Lines' },
    },
  },
  opts = {},
  init = function()
    -- Disable lsp_lines in lazy window
    Slivers.autocmds.autocmd('FileType', {
      group = Slivers.autocmds.augroup 'disable_lsp_lines',
      pattern = {
        'lazy',
      },
      callback = function(_) require('lsp_lines').toggle() end,
    })

    -- Re-enable lsp_lines when leaving lazy window
    Slivers.autocmds.autocmd('BufLeave', {
      group = Slivers.autocmds.augroup 'reenable_lsp_lines',
      pattern = {
        '*',
      },
      callback = function(_)
        if vim.bo.filetype == 'lazy' then require('lsp_lines').toggle() end
      end,
    })
  end,
}
