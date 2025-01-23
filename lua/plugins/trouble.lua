---@diagnostic disable: missing-parameter, missing-fields

---@type LazySpec
return {
  'folke/trouble.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  cmd = { 'Trouble' },
  keys = {
    {
      '<leader>qX',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Diagnostics',
    },
    {
      '<leader>qx',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (workspace)',
    },
    {
      '<leader>qq',
      '<cmd>Trouble fzf toggle<cr>',
      desc = 'Quickfix List',
    },
    {
      '<leader>cd',
      '<cmd>Trouble lsp toggle<cr>',
      desc = 'References/Definitions/...',
    },
    {
      '<leader>cs',
      '<cmd>Trouble symbols toggle<cr>',
      desc = 'Symbols',
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
  opts = {
    win = {
      position = 'left',
      size = 0.2,
    },
  },
  init = function()
    Slivers.autocmds.autocmd('FileType', {
      group = Slivers.autocmds.augroup 'resize_splits_on_trouble',
      pattern = 'trouble',
      callback = function()
        vim.schedule(function() vim.cmd 'wincmd =' end)
      end,
    })
  end,
}
