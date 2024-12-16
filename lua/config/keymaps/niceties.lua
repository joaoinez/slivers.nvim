local maps = Slivers.keymaps.get_mappings_template()

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
maps.n['<leader>cW'] = { [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], desc = 'Rename Word' }

-- Diagnostic keymaps
maps.n['<leader>qQ'] = { vim.diagnostic.setloclist, desc = 'Diagnostic Quickfix List' }
maps.n['<leader>ql'] = { vim.diagnostic.open_float, desc = 'Line Diagnostics' }
-- TODO: Check snacks toggle functionality
maps.n['<leader>tx'] = { function() Slivers.actions.toggle_diagnostics() end, desc = 'Diagnostics' }

-- keywordprg
maps.n['<leader>K'] = { '<cmd>norm! K<cr>', desc = 'Keywordprg' }

-- Inspect Tree
maps.n['<leader>cI'] = { '<cmd>InspectTree<cr>', desc = 'Inspect Tree' }

-- Terminal Mappings
maps.t['<C-/>'] = { '<cmd>close<cr>', desc = 'Hide Terminal' }
maps.t['<c-_>'] = { '<cmd>close<cr>', desc = 'which_key_ignore' }
maps.t['<C-h>'] = { '<C-\\><C-n><C-w>h', desc = 'Move focus to the left window' }
maps.t['<C-j>'] = { '<C-\\><C-n><C-w>j', desc = 'Move focus to the lower window' }
maps.t['<C-k>'] = { '<C-\\><C-n><C-w>k', desc = 'Move focus to the upper window' }
maps.t['<C-l>'] = { '<C-\\><C-n><C-w>l', desc = 'Move focus to the right window' }

-- Lazy
maps.n['<leader>,l'] = { function() require('lazy').check() end, desc = 'Lazy' }

-- mason
if Slivers.lazy.is_available 'mason.nvim' then
  maps.n['<leader>,m'] = { '<cmd>Mason<cr>', desc = 'Mason' }
  maps.n['<leader>,M'] = { '<cmd>MasonToolsUpdate<cr>', desc = 'Mason Update' }
end

-- treesitter
if Slivers.lazy.is_available 'nvim-treesitter' then
  maps.n['<leader>,t'] = { '<cmd>TSInstallInfo<cr>', desc = 'Treesitter' }
  maps.n['<leader>,T'] = { '<cmd>TSUpdate<cr>', desc = 'Treesitter Update' }
end

maps.n['<leader>fe'] = { function() Slivers.actions.explore() end, desc = 'File Explorer' }

-- TODO: See git conflict
--
-- nmap('<leader>fc', '/<<<<CR>', '[F]ind [C]onflicts')
-- nmap('<leader>gcu', 'dd/|||<CR>0v/>>><CR>$x', '[G]it [C]onflict Choose [U]pstream')
-- nmap('<leader>gcb', '0v/|||<CR>$x/====<CR>0v/>>><CR>$x', '[G]it [C]onflict Choose [B]ase')
-- nmap('<leader>gcs', '0v/====<CR>$x/>>><CR>dd', '[G]it [C]onflict Choose [S]tashed')

Slivers.keymaps.set_mappings(maps)
