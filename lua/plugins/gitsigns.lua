---@type LazySpec
return {
  'lewis6991/gitsigns.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePost' },
  opts = {
    signs = IconSliver.git.signs,
    signs_staged = IconSliver.git.staged,
    current_line_blame = true,
    ---@diagnostic disable-next-line: unused-local
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'
      local map = Slivers.keymaps.safe_keymap_set

      -- [[ Actions ]]
      -- Visual Mode
      map(
        'v',
        '<leader>ga',
        function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
        { desc = 'Add Hunk' }
      )
      map(
        'v',
        '<leader>gr',
        function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
        { desc = 'Reset Hunk' }
      )
      -- Normal Mode
      map('n', '<leader>ga', gitsigns.stage_hunk, { desc = 'Add Hunk' })
      map('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'Reset Hunk' })
      map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'Reset File' })
      map('n', '<leader>gd', gitsigns.preview_hunk, { desc = 'Diff Preview' })

      -- [[ Toggles ]]
      map('n', '<leader>tB', gitsigns.toggle_current_line_blame, { desc = 'Blame Line (git)' })

      -- [[ Navigation ]]
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { desc = 'Next Change (git)' })
      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = 'Previous Git Change (git)' })
    end,
  },
}
