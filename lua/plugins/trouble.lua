---@diagnostic disable: missing-parameter, missing-fields

return {
  'folke/trouble.nvim',
  cmd = { 'Trouble' },
  opts = {
    win = {
      position = 'right',
      size = 0.2,
    },
    modes = {
      telescope = {
        focus = true,
      },
    },
    -- preview = {
    --   type = 'float',
    --   relative = 'editor',
    --   border = 'none',
    --   title = 'Preview',
    --   title_pos = 'center',
    --   position = { 0, 0 },
    --   size = { width = 0.8, height = 1 },
    --   zindex = 200,
    -- },
  },
  keys = {
    {
      '<leader>dx',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>dS',
      '<cmd>Trouble symbols toggle<cr>',
      desc = 'Symbols (Trouble)',
    },
    {
      '<leader>wx',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>jR',
      '<cmd>Trouble lsp toggle<cr>',
      desc = 'References/Definitions/... (Trouble)',
    },
    {
      '<leader>q',
      '<cmd>Trouble telescope toggle<cr>',
      desc = 'Telescope Quicklist (Trouble)',
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
      desc = 'Previous Trouble/Quickfix Item',
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
      desc = 'Next Trouble/Quickfix Item',
    },
  },
}
