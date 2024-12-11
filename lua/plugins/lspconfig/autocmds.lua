local M = {}

--- @param client vim.lsp.Client|nil The client where the lsp mappings will load.
--- @param bufnr integer The bufnr where the lsp mappings will load.
function M.apply_user_lsp_autocmds(client, bufnr)
  local utils = require 'utils'
  local autocmd = utils.autocmd
  local augroup = utils.augroup
  local supports = utils.supports(client)

  if supports 'textDocument_documentHighlight' then
    utils.add_autocmds_to_buffer('slivers_lsp_highlight', bufnr, {
      {
        events = { 'CursorHold', 'CursorHoldI' },
        callback = vim.lsp.buf.document_highlight,
      },
      {
        events = { 'CursorMoved', 'CursorMovedI' },
        callback = vim.lsp.buf.clear_references,
      },
    })

    autocmd('LspDetach', {
      group = augroup 'lsp_detach',
      callback = function(e)
        vim.lsp.buf.clear_references()
        utils.del_autocmds_from_buffer('slivers_lsp_highlight', e.buf)
      end,
    })
  end

  autocmd({ 'BufReadPost', 'BufNewFile' }, {
    pattern = {
      '*.js',
      '*.jsx',
      '*.ts',
      '*.tsx',
      '*.vue',
    },
    callback = function(args)
      vim.schedule(function() vim.api.nvim_set_current_buf(args.buf) end)
    end,
  })
end

return M
