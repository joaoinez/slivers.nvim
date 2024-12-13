return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {},
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'PersistenceSavePre',
      callback = function()
        if require('trouble').is_open() then require('trouble').close() end

        -- TODO: Close dap ui

        require('snacks').bufdelete.other { force = true }
      end,
    })
  end,
}
