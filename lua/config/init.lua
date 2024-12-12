_G.SliverUtils = require 'utils'

-- [[ Options ]]
require 'config.options'

-- [[ Keymaps ]]
require 'config.keymaps'

-- [[ Lazy ]]
require 'config.lazy'

-- [[ Apply Colorscheme ]]
vim.cmd.colorscheme 'catppuccin'

-- [[ Autocmds ]]
require 'config.autocmds'
