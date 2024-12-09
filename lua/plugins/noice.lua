return {
  'folke/noice.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  event = 'VeryLazy',
  opts = {
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
      },
    },
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
  },
  keys = {
    {
      '<S-Enter>',
      function() require('noice').redirect(vim.fn.getcmdline()) end,
      mode = 'c',
      desc = 'Redirect Cmdline',
    },
    { '<leader>fml', function() require('noice').cmd 'last' end, desc = 'Last Message (noice)' },
    { '<leader>fmH', function() require('noice').cmd 'history' end, desc = 'Message History (noice)' },
    { '<leader>fmd', function() require('noice').cmd 'dismiss' end, desc = 'Dismiss All Messages' },
    { '<leader>fmt', function() require('noice').cmd 'pick' end, desc = 'Noice Picker (Telescope/FzfLua)' },
  },
}
