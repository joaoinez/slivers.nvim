local utils = require 'utils'
local maps = utils.get_mappings_template()

-- Save file
maps.n['<leader>s'] = { '<cmd>w<cr>', desc = 'Save File' }

-- Save and quit Neovim
maps.n['<leader>x'] = { '<cmd>wqa<cr>', desc = 'Save and Quit Neovim' }

-- use ESC to clear hlsearch, while preserving its original functionality.
maps.n['<ESC>'] = {
  function()
    if vim.fn.hlexists 'Search' then
      vim.cmd 'nohlsearch'
    else
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<ESC>', true, true, true), 'n', true)
    end
  end,
}

-- Toggle comments
maps.n['<leader>/'] = { 'gcc', remap = true, desc = 'Toggle comment line' }
maps.x['<leader>/'] = { 'gc', remap = true, desc = 'Toggle comment selection' }

-- Splits
maps.n['<leader>|'] = { '<cmd>vsplit<cr>', desc = 'Vertical Split' }
maps.n['<leader>\\'] = { '<cmd>split<cr>', desc = 'Horizontal Split' }

-- Enable `<C-backspace>` to delete
maps.i['<C-BS>'] = { '<C-W>', desc = 'Enable `<C-backspace>` to delete.' }

-- Block insert in line visual mode
maps.x['I'] = { function() return vim.fn.mode() == 'V' and '^<C-v>I' or 'I' end, expr = true }
maps.x['A'] = { function() return vim.fn.mode() == 'V' and '$<C-v>A' or 'A' end, expr = true }

-- From the Vim wiki: https://bit.ly/4eLAARp
-- Search and replace word under the cursor
maps.n['<Leader>r'] = { [[:%s/\<<C-r><C-w>\>//g<Left><Left>]] }

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>qQ', vim.diagnostic.setloclist, { desc = 'Diagnostic Quickfix List' })

-- TODO: Check for conflicting keymap here
--
-- Insert arrow
-- maps.i['<C-l>'] = { '<space>=><space>', desc = 'Inserts arrow' }

-- TODO: See git conflict
--
-- nmap('<leader>fc', '/<<<<CR>', '[F]ind [C]onflicts')
-- nmap('<leader>gcu', 'dd/|||<CR>0v/>>><CR>$x', '[G]it [C]onflict Choose [U]pstream')
-- nmap('<leader>gcb', '0v/|||<CR>$x/====<CR>0v/>>><CR>$x', '[G]it [C]onflict Choose [B]ase')
-- nmap('<leader>gcs', '0v/====<CR>$x/>>><CR>dd', '[G]it [C]onflict Choose [S]tashed')

utils.set_mappings(maps)
