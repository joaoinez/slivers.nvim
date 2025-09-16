---@type LazySpec
return {
  'folke/noice.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  event = 'VeryLazy',
  keys = {
    {
      '<S-Enter>',
      function() require('noice').redirect(vim.fn.getcmdline()) end,
      mode = 'c',
      desc = 'Redirect Cmdline',
    },
    { '<leader>nl', function() require('noice').cmd 'last' end, desc = 'Last Message' },
    { '<leader>nh', function() require('noice').cmd 'history' end, desc = 'Message History (noice)' },
    { '<leader>nH', function() require('noice').cmd 'pick' end, desc = 'Message History (snacks)' },
    { '<leader>nd', function() require('noice').cmd 'dismiss' end, desc = 'Dismiss All Messages' },
    { '<leader>np', function() require('noice').cmd 'pick' end, desc = 'Pick Message' },
  },
  opts = {
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
    },
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
      },
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
            { find = '%d lines <ed %d time' },
            { find = '%d lines >ed %d time' },
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
            { find = 'W325: Ignoring swapfile from Nvim process %d' },
            { find = 'does not support command' },
            { find = 'deprecated' },
          },
        },
        view = 'mini',
      },
      {
        filter = {
          any = {
            { find = 'Initializing: %s' },
            { find = 'Roslyn project initialization complete' },
            { find = 'Restore started' },
            { find = 'Running dotnet restore on' },
            {
              find = 'error MSB4025: The project file could not be loaded. Data at the root level is invalid.',
            },
            { find = 'Failed to run restore on' },
            { find = 'Restore complete' },
          },
        },
        view = 'mini',
      },
    },
  },
  config = function(_, opts)
    -- HACK: noice shows messages from before it was enabled,
    -- but this is not ideal when Lazy is installing plugins,
    -- so clear the messages in this case.
    if vim.o.filetype == 'lazy' then vim.cmd [[messages clear]] end
    require('noice').setup(opts)
  end,
}
