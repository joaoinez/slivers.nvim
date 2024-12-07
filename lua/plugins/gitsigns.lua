return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '▎' },
      untracked = { text = '▎' },
    },
    signs_staged = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '▎' },
    },
    on_attach = function(bufnr)
      -- local gitsigns = require 'gitsigns'
      -- local bmap = require('util').bmap(bufnr)
      --
      -- -- Navigation
      -- bmap(']c', function()
      --   if vim.wo.diff then
      --     vim.cmd.normal { ']c', bang = true }
      --   else
      --     gitsigns.nav_hunk 'next'
      --   end
      -- end, { desc = 'Next Git Change' })
      --
      -- bmap('[c', function()
      --   if vim.wo.diff then
      --     vim.cmd.normal { '[c', bang = true }
      --   else
      --     gitsigns.nav_hunk 'prev'
      --   end
      -- end, { desc = 'Previous Git Change' })
      --
      -- -- Actions
      -- -- visual mode
      -- bmap('<leader>gs', function()
      --   gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      -- end, { desc = 'Stage Hunk' }, 'v')
      -- bmap('<leader>gr', function()
      --   gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      -- end, { desc = 'Reset Hunk' }, 'v')
      -- -- normal mode
      -- bmap('<leader>gs', gitsigns.stage_hunk, { desc = 'Stage Hunk' })
      -- bmap('<leader>gr', gitsigns.reset_hunk, { desc = 'Reset Hunk' })
      -- bmap('<leader>gS', gitsigns.stage_buffer, { desc = 'Stage File' })
      -- bmap('<leader>gu', gitsigns.undo_stage_hunk, { desc = 'Undo Stage Hunk' })
      -- bmap('<leader>gR', gitsigns.reset_buffer, { desc = 'Reset File' })
      -- bmap('<leader>gp', gitsigns.preview_hunk, { desc = 'Preview Hunk' })
      -- bmap('<leader>gb', gitsigns.blame_line, { desc = 'Blame Line' })
      -- bmap('<leader>gd', gitsigns.diffthis, { desc = 'Diff against index' })
      -- bmap('<leader>gD', function()
      --   gitsigns.diffthis '@'
      -- end, { desc = 'Diff against last commit' })
      -- -- Toggles
      -- bmap('<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Blame Line (Git)' })
      -- bmap('<leader>td', gitsigns.toggle_deleted, { desc = 'Deleted Hunks (Git)' })
    end,
  },
}
