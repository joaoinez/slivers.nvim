_G.SliverUtils = require 'utils'

-- [[ Options ]]
require 'config.options'

-- [[ Lazy ]]
require 'config.lazy'

-- [[ Keymaps ]]
require 'config.keymaps'

-- [[ Apply Colorscheme ]]
vim.cmd.colorscheme 'catppuccin'

-- [[ Autocmds ]]
require 'config.autocmds'
