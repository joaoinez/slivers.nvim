-- TODO: Remove No information available notification and no lines in buffer as well
return {
  'folke/noice.nvim',
  enabled = true,
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  event = 'VeryLazy',
  keys = {
    {
      '<S-Enter>',
      function() require('noice').redirect(vim.fn.getcmdline()) end,
      mode = 'c',
      desc = 'Redirect Cmdline',
    },
    { '<leader>ml', function() require('noice').cmd 'last' end, desc = 'Last Message' },
    { '<leader>mH', function() require('noice').cmd 'history' end, desc = 'Message History (noice)' },
    { '<leader>md', function() require('noice').cmd 'dismiss' end, desc = 'Dismiss All Messages' },
    { '<leader>mp', function() require('noice').cmd 'pick' end, desc = 'Pick Message' },
  },
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
    routes = {
      {
        filter = {
          event = 'msg_show',
          any = {
            { find = '%d+L, %d+B' },
            { find = '; after #%d+' },
            { find = '; before #%d+' },
            { find = '%d fewer lines' },
            { find = '%d more lines' },
            { find = 'written' },
            { find = 'yanked' },
            { find = 'No lines in buffer' },
          },
        },
        view = 'mini',
      },
      {
        filter = {
          any = {
            { find = 'No information available' },
          },
        },
        view = 'mini',
      },
    },
  },
}
