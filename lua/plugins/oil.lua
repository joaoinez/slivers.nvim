---@type LazySpec
return {
  'stevearc/oil.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  lazy = false,
  keys = {
    {
      '<leader>fo',
      '<cmd>Oil<cr>',
      desc = 'File Explorer (oil)',
    },
  },
  opts = function()
    local detail = false

    return {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ['q'] = { 'actions.close', mode = 'n' },
        ['gd'] = {
          desc = 'Toggle file detail view',
          callback = function()
            detail = not detail
            if detail then
              require('oil').set_columns { 'icon', 'permissions', 'size', 'mtime' }
            else
              require('oil').set_columns { 'icon' }
            end
          end,
        },
        ['s'] = {
          desc = 'Save state',
          callback = function() vim.cmd 'w' end,
        },
      },
    }
  end,
  init = function()
    Slivers.autocmds.autocmd('User', {
      pattern = 'OilEnter',
      callback = vim.schedule_wrap(function(args)
        local oil = require 'oil'
        if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then oil.open_preview() end
      end),
    })
  end,
}
