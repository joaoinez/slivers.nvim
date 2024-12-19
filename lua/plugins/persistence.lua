---@type LazySpec
return {
  'folke/persistence.nvim',
  enabled = true,
  event = 'BufReadPre',
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'PersistenceSavePre',
      callback = function()
        -- Delete all other buffers except the current one
        local current_bufnr = vim.fn.bufnr()
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
          if bufnr ~= current_bufnr then vim.api.nvim_buf_delete(bufnr, { force = true }) end
        end
      end,
    })
  end,
  opts = {},
}
