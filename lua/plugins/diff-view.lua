---@type LazySpec
return {
  'sindrets/diffview.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  event = 'VeryLazy',
  lazy = true,
  cmd = { 'DiffViewOpen' },
  keys = {
    {
      '<leader>gd',
      '<cmd>DiffviewOpen<cr>',
      desc = 'Diffview',
    },
    {
      '<leader>gh',
      '<cmd>DiffviewFileHistory --follow %<cr>',
      desc = 'History (file)',
    },
    {
      '<leader>gh',
      "<esc><cmd>'<,'>DiffviewFileHistory --follow<cr>",
      mode = 'v',
      desc = 'History (selection)',
    },
    {
      '<leader>gH',
      '<cmd>DiffviewFileHistory<cr>',
      desc = 'History (project)',
    },
    {
      '<leader>gm',
      '<cmd>DiffviewOpen main..HEAD<cr>',
      desc = 'Diffview (main)',
    },
    {
      '<leader>g-',
      '<cmd>DiffviewOpen HEAD~1..HEAD<cr>',
      desc = 'Diffview (prev commit)',
    },
  },
  opts = function()
    local actions = require 'diffview.actions'

    return {
      -- hooks = {
      --   diff_buf_read = function(bufnr)
      --     -- TODO: Try this
      --
      --     if Slivers.lazy.is_loaded 'git-conflict' and require('git-conflict').conflict_count(bufnr) > 0 then
      --       require('git-conflict').clear(bufnr)
      --     end
      --   end,
      --   view_opened = function(bufnr)
      --     Slivers.lazy.on_load('which-key.nvim', function()
      --       vim.schedule(
      --         function()
      --           require('which-key').add {
      --             { '<leader>gd', group = 'diff' },
      --           }
      --         end
      --       )
      --     end)
      --   end,
      --   view_closed = function(bufnr) end,
      -- },
      keymaps = {
        view = {
          { 'n', '<leader>fo', '<nop>' },
          { 'n', '<leader>fd', '<nop>' },
          { 'n', '<leader>fg', '<nop>' },
          { 'n', '<leader>fh', '<nop>' },
          { 'n', '<leader>f,', '<nop>' },
          { 'n', '<leader>h', '<nop>' },
          { 'n', '<leader><leader>', '<nop>' },
          { 'n', '<leader><tab>', '<nop>' },
          { 'n', '<leader>|', '<nop>' },
          { 'n', '<leader>\\', '<nop>' },
          { 'n', '<leader>x', '<cmd>tabclose<cr>', { desc = 'Close Diffview' } },
          { 'n', '<leader>wq', '<cmd>tabclose<cr>', { desc = 'Close Diffview' } },
          { 'n', '<leader>gdp', require('gitsigns').preview_hunk, { desc = 'Diff Preview' } },
          { 'n', '<leader>ff', actions.focus_files, { desc = 'Focus File Panel' } },
          { 'n', '<leader>fe', actions.toggle_files, { desc = 'File Panel' } },
          {
            'n',
            '<leader>gdo',
            actions.conflict_choose 'ours',
            { desc = 'Choose Ours' },
          },
          {
            'n',
            '<leader>gdt',
            actions.conflict_choose 'theirs',
            { desc = 'Choose Theirs' },
          },
          {
            'n',
            '<leader>gdb',
            actions.conflict_choose 'base',
            { desc = 'Choose Base' },
          },
          {
            'n',
            '<leader>gda',
            actions.conflict_choose 'all',
            { desc = 'Choose All' },
          },
          {
            'n',
            '<leader>gdO',
            actions.conflict_choose_all 'ours',
            { desc = 'Choose Ours (file)' },
          },
          {
            'n',
            '<leader>gdT',
            actions.conflict_choose_all 'theirs',
            { desc = 'Choose Theirs (file)' },
          },
          {
            'n',
            '<leader>gdB',
            actions.conflict_choose_all 'base',
            { desc = 'Choose Base (file)' },
          },
          {
            'n',
            '<leader>gdA',
            actions.conflict_choose_all 'all',
            { desc = 'Choose All (file)' },
          },
        },
        file_panel = {
          { 'n', '<leader>fo', '<nop>' },
          { 'n', '<leader>fd', '<nop>' },
          { 'n', '<leader>fg', '<nop>' },
          { 'n', '<leader>fh', '<nop>' },
          { 'n', '<leader>f,', '<nop>' },
          { 'n', '<leader>h', '<nop>' },
          { 'n', '<leader><leader>', '<nop>' },
          { 'n', '<leader><tab>', '<nop>' },
          { 'n', '<leader>|', '<nop>' },
          { 'n', '<leader>\\', '<nop>' },
          { 'n', '<leader>x', '<cmd>tabclose<cr>', { desc = 'Close Diffview' } },
          { 'n', '<leader>wq', '<cmd>tabclose<cr>', { desc = 'Close Diffview' } },
          {
            'n',
            'j',
            actions.select_next_entry,
            { desc = 'Open the diff for the next file' },
          },
          {
            'n',
            'k',
            actions.select_prev_entry,
            { desc = 'Open the diff for the previous file' },
          },
          { 'n', 'q', '<cmd>tabclose<cr>', { desc = 'Close Diffview' } },
          {
            'n',
            '<cr>',
            actions.toggle_files,
            { desc = 'Open the diff for the selected entry' },
          },
          { 'n', '<leader>ff', actions.focus_files, { desc = 'Focus File Panel' } },
          { 'n', '<leader>fe', actions.toggle_files, { desc = 'File Panel' } },
          {
            'n',
            '<leader>gdO',
            actions.conflict_choose_all 'ours',
            { desc = 'Choose Ours (file)' },
          },
          {
            'n',
            '<leader>gdT',
            actions.conflict_choose_all 'theirs',
            { desc = 'Choose Theirs (file)' },
          },
          {
            'n',
            '<leader>gdB',
            actions.conflict_choose_all 'base',
            { desc = 'Choose Base (file)' },
          },
          {
            'n',
            '<leader>gdA',
            actions.conflict_choose_all 'all',
            { desc = 'Choose All (file)' },
          },
        },
        file_history_panel = {
          { 'n', '<leader>fo', '<nop>' },
          { 'n', '<leader>fd', '<nop>' },
          { 'n', '<leader>fg', '<nop>' },
          { 'n', '<leader>fh', '<nop>' },
          { 'n', '<leader>f,', '<nop>' },
          { 'n', '<leader>h', '<nop>' },
          { 'n', '<leader><leader>', '<nop>' },
          { 'n', '<leader><tab>', '<nop>' },
          { 'n', '<leader>|', '<nop>' },
          { 'n', '<leader>\\', '<nop>' },
          { 'n', '<leader>x', '<cmd>tabclose<cr>', { desc = 'Close Diffview' } },
          { 'n', '<leader>wq', '<cmd>tabclose<cr>', { desc = 'Close Diffview' } },
          {
            'n',
            'j',
            actions.select_next_entry,
            { desc = 'Open the diff for the next file' },
          },
          {
            'n',
            'k',
            actions.select_prev_entry,
            { desc = 'Open the diff for the previous file' },
          },
          { 'n', 'q', '<cmd>tabclose<cr>', { desc = 'Close Diffview' } },
          {
            'n',
            '<cr>',
            actions.toggle_files,
            { desc = 'Open the diff for the selected entry' },
          },
          { 'n', '<leader>ff', actions.focus_files, { desc = 'Focus File Panel' } },
          { 'n', '<leader>fe', actions.toggle_files, { desc = 'File Panel' } },
        },
      },
    }
  end,
}
