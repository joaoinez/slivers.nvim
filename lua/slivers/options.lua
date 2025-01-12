-- [[ Globals ]]
vim.g.mapleader = ' ' -- Set leader key.
vim.g.maplocalleader = ' ' -- Set default local leader key.

-- Source globals from config file
local path = vim.fn.stdpath 'config' .. '/.slivers.json'
if Slivers.misc.file_exists(path) then
  local config = vim.json.decode(Slivers.misc.read_file(path))

  for global, value in pairs(config) do
    vim.g[global] = value
  end
else
  local default_config = {
    transparent_bg = true, -- Set transparent background.
    mode_len = 3, -- Set mode text length; 0 is Neovim's default.
    dark_mode = true, -- Set background dark mode.
    lualine_borders = true, -- Set lualine rounded borders.
    trouble_lualine = true, -- Show the current document symbols location from Trouble in lualine.
  }

  Slivers.misc.write_file(path, vim.json.encode(default_config))

  for global, value in pairs(default_config) do
    vim.g[global] = value
  end
end

-- [[ Options ]]
vim.opt.background = vim.g.dark_mode and 'dark' or 'light' -- Set background to either dark or light.
vim.opt.breakindent = true -- Wrap indent to match line start.
vim.opt.cmdheight = 0 -- Hide command line unless needed.
vim.opt.colorcolumn = '80' -- Show character limit vertical bar.
vim.opt.completeopt = { -- Options for insert mode completion.
  'menu',
  'menuone',
  'noselect',
}
vim.opt.copyindent = true -- Copy the previous indentation on autoindenting.
vim.opt.conceallevel = 2 -- Hide markup symbols for bold and italic, but not markers with substitutions.
vim.opt.confirm = true -- Confirm to save changes before exiting modified buffer.
vim.opt.cursorline = true -- Highlight the text line of the cursor.
vim.opt.expandtab = true -- Enable the use of space in tab.
vim.opt.fillchars = { -- Characters to fill the statuslines, vertical separators and special lines in the window.
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}
vim.opt.foldcolumn = '1' -- Show fold column.
vim.opt.foldenable = true -- Enable folds.
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- Folding based on treesitter.
vim.opt.foldmethod = 'expr' -- Set fold method to expression.
vim.opt.foldtext = '' -- Remove fold text.
vim.opt.foldlevel = 99 -- Set fold level to highest value.
vim.opt.foldlevelstart = 99 -- Start with all code unfolded.
vim.opt.guicursor = 'n-c-sm:block,\z
i-ci-ve:ver25-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,\z
v-r-cr-o:hor20' -- Cursor styling
vim.opt.ignorecase = true -- Case insensitive searching.
vim.opt.inccommand = 'split' -- Show incremental substitute in a preview window.
vim.opt.infercase = true -- Infer cases in keyword completion.
vim.opt.laststatus = 3 -- Show global status.
vim.opt.linebreak = true -- Wrap lines at convenient places (`breakat`).
vim.opt.list = true -- Show whitespace characters.
vim.opt.listchars = { -- List of whitespace characters.
  tab = '» ',
  trail = '·',
  nbsp = '␣',
}
vim.opt.mouse = 'a' -- Enable mouse mode.
vim.opt.number = true -- Show numberline.
vim.opt.preserveindent = true -- Preserve indent structure as much as possible.
vim.opt.pumheight = 10 -- Maximum number of entries in a popup.
vim.opt.relativenumber = true -- Show relative numberline.
vim.opt.ruler = false -- Disable the default ruler.
vim.opt.scrolloff = 10 -- Number of lines to leave before/after the cursor when scrolling. Setting a high value keeps the cursor centered.
vim.opt.shiftround = true -- Round indent.
vim.opt.shiftwidth = 2 -- Number of space inserted for indentation.
vim.opt.shortmess:append { W = true, I = true, c = true, C = true } -- Disable various messages.
vim.opt.showmode = false -- Disable showing modes in command line.
vim.opt.sidescrolloff = 8 -- Same as vim.opt.scrolloff but for side scrolling.
vim.opt.signcolumn = 'yes' -- Always show the sign column.
vim.opt.smartcase = true -- Case sensitivie searching.
vim.opt.smartindent = false -- Smarter autoindentation.
vim.opt.smoothscroll = true -- Enable smooth scrolling.
vim.opt.splitbelow = true -- Splits new windows below the current one.
vim.opt.splitright = true -- Splits new windows at the right of the current one.
vim.opt.tabstop = 2 -- Number of space in a tab.
vim.opt.termguicolors = true -- Enable 24-bit RGB color in the TUI.
vim.opt.timeoutlen = 300 -- Shorten key timeout length a little bit for which-key.
vim.opt.undofile = true -- Enable persistent undo between session and reboots.
vim.opt.updatetime = 250 -- Length of time to wait before triggering the plugin.
vim.opt.virtualedit = 'block' -- Allow going past end of line in visual block mode.
vim.opt.wrap = true -- Enable line wraping.
vim.opt.wildmode = 'longest:full,full' -- Command line completion mode.

vim.schedule(function() -- Schedule the setting after `UiEnter`.
  vim.opt.clipboard = 'unnamedplus' -- Sync with system clipboard.
end)
