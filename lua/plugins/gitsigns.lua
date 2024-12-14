return {
  'lewis6991/gitsigns.nvim',
  enabled = true,
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePost' },
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
      local gitsigns = require 'gitsigns'
      local maps = require('utils.keymaps').get_mappings_template()

      -- Actions
      -- visual mode
      maps.v['<leader>gs'] =
        { function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, desc = 'Stage Hunk' }
      maps.v['<leader>gr'] =
        { function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, desc = 'Reset Hunk' }
      -- normal mode
      maps.n['<leader>gs'] = { gitsigns.stage_hunk, desc = 'Stage Hunk' }
      maps.n['<leader>gr'] = { gitsigns.reset_hunk, desc = 'Reset Hunk' }
      maps.n['<leader>gS'] = { gitsigns.stage_buffer, desc = 'Stage File' }
      maps.n['<leader>gu'] = { gitsigns.undo_stage_hunk, desc = 'Undo Stage Hunk' }
      maps.n['<leader>gR'] = { gitsigns.reset_buffer, desc = 'Reset File' }
      maps.n['<leader>gp'] = { gitsigns.preview_hunk, desc = 'Preview Hunk' }
      maps.n['<leader>gb'] = { gitsigns.blame_line, desc = 'Blame Line' }
      maps.n['<leader>gd'] = { gitsigns.diffthis, desc = 'Diff against index' }
      maps.n['<leader>gD'] = { function() gitsigns.diffthis '@' end, desc = 'Diff against last commit' }
      -- Toggles
      maps.n['<leader>tB'] = { gitsigns.toggle_current_line_blame, desc = 'Blame Line (git)' }
      maps.n['<leader>tD'] = { gitsigns.toggle_deleted, desc = 'Deleted Hunks (git)' }
      -- Navigation
      maps.n[']c'] = {
        function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end,
        desc = 'Next Change (git)',
      }
      maps.n['[c'] = {
        function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end,
        desc = 'Previous Git Change (git)',
      }

      require('utils.keymaps').set_mappings(maps, { buffer = bufnr })
    end,
  },
}
