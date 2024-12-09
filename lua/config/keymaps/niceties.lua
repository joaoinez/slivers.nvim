local utils = require 'utils'
local maps = utils.get_mappings_template()

--  Use CTRL+<hjkl> to switch between windows
maps.n['<C-h>'] = { '<C-w><C-h>', desc = 'Move focus to the left window' }
maps.n['<C-j>'] = { '<C-w><C-j>', desc = 'Move focus to the lower window' }
maps.n['<C-k>'] = { '<C-w><C-k>', desc = 'Move focus to the upper window' }
maps.n['<C-l>'] = { '<C-w><C-l>', desc = 'Move focus to the right window' }

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

-- Improved tabulation
maps.x['<S-Tab>'] = { '<gv', desc = 'unindent line' }
maps.x['<Tab>'] = { '>gv', desc = 'indent line' }
maps.x['<'] = { '<gv', desc = 'unindent line' }
maps.x['>'] = { '>gv', desc = 'indent line' }

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
maps.n['<leader>cR'] = { [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], desc = 'Rename Word' }

-- Diagnostic keymaps
maps.n['<leader>qQ'] = { vim.diagnostic.setloclist, desc = 'Diagnostic Quickfix List' }
maps.n['<leader>qd'] = { vim.diagnostic.open_float, desc = 'Line Diagnostics' }

-- keywordprg
maps.n['<leader>K'] = { '<cmd>norm! K<cr>', desc = 'Keywordprg' }

-- Lazy
maps.n['<leader>,l'] = { function() require('lazy').check() end, desc = 'Lazy open' }

-- Inspect Tree
maps.n['<leader>cI'] = { '<cmd>InspectTree<cr>', desc = 'Inspect Tree' }

-- Terminal Mappings
maps.t['<C-/>'] = { '<cmd>close<cr>', desc = 'Hide Terminal' }
maps.t['<c-_>'] = { '<cmd>close<cr>', desc = 'which_key_ignore' }
maps.t['<C-h>'] = { '<C-\\><C-n><C-w>h', desc = 'Move focus to the left window' }
maps.t['<C-j>'] = { '<C-\\><C-n><C-w>j', desc = 'Move focus to the lower window' }
maps.t['<C-k>'] = { '<C-\\><C-n><C-w>k', desc = 'Move focus to the upper window' }
maps.t['<C-l>'] = { '<C-\\><C-n><C-w>l', desc = 'Move focus to the right window' }

-- -- mason
-- if is_available 'mason.nvim' then
--   maps.n['<leader>pm'] = { '<cmd>Mason<cr>', desc = 'Mason open' }
--   maps.n['<leader>pM'] = { '<cmd>MasonUpdateAll<cr>', desc = 'Mason update' }
-- end
--
-- -- treesitter
-- if is_available 'nvim-treesitter' then
--   maps.n['<leader>pT'] = { '<cmd>TSUpdate<cr>', desc = 'Treesitter update' }
--   maps.n['<leader>pt'] = { '<cmd>TSInstallInfo<cr>', desc = 'Treesitter open' }
-- end

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
