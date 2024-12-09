local utils = require 'utils'
local maps = utils.get_mappings_template()

-- Better up/down
maps.n['j'] = { "v:count == 0 ? 'gj' : 'j'", expr = true, desc = 'Move cursor down' }
maps.x['j'] = { "v:count == 0 ? 'gj' : 'j'", expr = true, desc = 'Move cursor down' }
maps.n['k'] = { "v:count == 0 ? 'gk' : 'k'", expr = true, desc = 'Move cursor up' }
maps.x['k'] = { "v:count == 0 ? 'gk' : 'k'", expr = true, desc = 'Move cursor up' }

-- Page jumping centers cursor
maps.n['<C-d>'] = { '<C-d>zz', desc = 'Scrolls down the page and center the cursor' }
maps.n['<C-u>'] = { '<C-u>zz', desc = 'Scrolls up the page and center the cursor' }

-- Search centers cursor
maps.n['n'] = { 'nzzzv', desc = 'Jump to next search result and center the cursor' }
maps.n['N'] = { 'Nzzzv', desc = 'Jump to previous search result and center the cursor' }

--  Use CTRL+<hjkl> to switch between windows
maps.n['<C-h>'] = { '<C-w><C-h>', desc = 'Move focus to the left window' }
maps.n['<C-j>'] = { '<C-w><C-j>', desc = 'Move focus to the lower window' }
maps.n['<C-k>'] = { '<C-w><C-k>', desc = 'Move focus to the upper window' }
maps.n['<C-l>'] = { '<C-w><C-l>', desc = 'Move focus to the right window' }

-- Improved tabulation
maps.x['<S-Tab>'] = { '<gv', desc = 'unindent line' }
maps.x['<Tab>'] = { '>gv', desc = 'indent line' }
maps.x['<'] = { '<gv', desc = 'unindent line' }
maps.x['>'] = { '>gv', desc = 'indent line' }

utils.set_mappings(maps)
