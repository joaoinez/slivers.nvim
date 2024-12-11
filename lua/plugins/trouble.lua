---@diagnostic disable: missing-parameter, missing-fields

return {
  'folke/trouble.nvim',
  cmd = { 'Trouble' },
  opts = {
    win = {
      position = 'left',
      size = 0.2,
    },
    modes = {
      telescope = {
        focus = true,
      },
    },
  },
  keys = {
    {
      '<leader>qX',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Diagnostics (trouble)',
    },
    {
      '<leader>qx',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Workspace Diagnostics (trouble)',
    },
    {
      '<leader>qq',
      '<cmd>Trouble telescope toggle<cr>',
      desc = 'Telescope Quicklist (trouble)',
    },
    {
      '<leader>cd',
      '<cmd>Trouble lsp toggle<cr>',
      desc = 'References/Definitions/... (trouble)',
    },
    {
      '<leader>cs',
      '<cmd>Trouble symbols toggle<cr>',
      desc = 'Symbols (trouble)',
    },
    {
      '[q',
      function()
        if require('trouble').is_open() then
          require('trouble').prev { skip_groups = true, jump = true }
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then vim.notify(err, vim.log.levels.ERROR) end
        end
      end,
      desc = 'Previous Trouble/Quickfix Item (trouble)',
    },
    {
      ']q',
      function()
        if require('trouble').is_open() then
          require('trouble').next { skip_groups = true, jump = true }
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok then vim.notify(err, vim.log.levels.ERROR) end
        end
      end,
      desc = 'Next Trouble/Quickfix Item (trouble)',
    },
  },
}
