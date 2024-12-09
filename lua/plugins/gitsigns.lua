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
      local gitsigns = require 'gitsigns'
      local utils = require 'utils'
      local maps = utils.get_mappings_template()

      -- Actions
      -- visual mode
      maps.v['<leader>gs'] = {
        function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
        { buffer = bufnr, desc = 'Stage Hunk' },
      }
      maps.v['<leader>gr'] = {
        function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
        { buffer = bufnr, desc = 'Reset Hunk' },
      }
      -- normal mode
      maps.n['<leader>gs'] = { gitsigns.stage_hunk, { buffer = bufnr, desc = 'Stage Hunk' } }
      maps.n['<leader>gr'] = { gitsigns.reset_hunk, { buffer = bufnr, desc = 'Reset Hunk' } }
      maps.n['<leader>gS'] = { gitsigns.stage_buffer, { buffer = bufnr, desc = 'Stage File' } }
      maps.n['<leader>gu'] = { gitsigns.undo_stage_hunk, { buffer = bufnr, desc = 'Undo Stage Hunk' } }
      maps.n['<leader>gR'] = { gitsigns.reset_buffer, { buffer = bufnr, desc = 'Reset File' } }
      maps.n['<leader>gp'] = { gitsigns.preview_hunk, { buffer = bufnr, desc = 'Preview Hunk' } }
      maps.n['<leader>gb'] = { gitsigns.blame_line, { buffer = bufnr, desc = 'Blame Line' } }
      maps.n['<leader>gd'] = { gitsigns.diffthis, { buffer = bufnr, desc = 'Diff against index' } }
      maps.n['<leader>gD'] = {
        function() gitsigns.diffthis '@' end,
        { buffer = bufnr, desc = 'Diff against last commit' },
      }
      -- Toggles
      maps.n['<leader>tb'] = { gitsigns.toggle_current_line_blame, { buffer = bufnr, desc = 'Blame Line (git)' } }
      maps.n['<leader>td'] = { gitsigns.toggle_deleted, { buffer = bufnr, desc = 'Deleted Hunks (git)' } }
      -- Navigation
      maps.n[']c'] = {
        function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end,
        { buffer = bufnr, desc = 'Next Change (git)' },
      }
      maps.n['[c'] = {
        function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end,
        { buffer = bufnr, desc = 'Previous Git Change (git)' },
      }
    end,
  },
}
