-- [[ Variables ]]
local options = {
  g = {
    have_nerd_font = true, -- If a Nerd Font is installed and set in the terminal.
    mapleader = ' ', -- Set leader key.
    maplocalleader = ' ', -- Set default local leader key.
  },
  opt = {
    breakindent = true, -- Wrap indent to match line start.
    cmdheight = 0, -- Hide command line unless needed.
    colorcolumn = '80', -- Show character limit vertical bar.
    completeopt = { -- Options for insert mode completion.
      'menu',
      'menuone',
      'noselect',
    },
    copyindent = true, -- Copy the previous indentation on autoindenting.
    conceallevel = 2, -- Hide markup symbols for bold and italic, but not markers with substitutions.
    confirm = true, -- Confirm to save changes before exiting modified buffer.
    cursorline = true, -- Highlight the text line of the cursor.
    expandtab = true, -- Enable the use of space in tab.
    fillchars = { -- Characters to fill the statuslines, vertical separators and special lines in the window.
      foldopen = '',
      foldclose = '',
      fold = ' ',
      foldsep = ' ',
      diff = '╱',
      eob = ' ',
    },
    foldcolumn = '1', -- Show fold column.
    foldenable = true, -- Enable folds.
    foldexpr = 'v:lua.vim.treesitter.foldexpr()', -- Folding based on treesitter.
    foldmethod = 'expr', -- Set fold method to expression.
    foldtext = '', -- Remove fold text.
    foldlevel = 99, -- Set fold level to highest value.
    foldlevelstart = 99, -- Start with all code unfolded.
    ignorecase = true, -- Case insensitive searching.
    inccommand = 'split', -- Show incremental substitute in a preview window.
    infercase = true, -- Infer cases in keyword completion.
    laststatus = 3, -- Show global status.
    linebreak = true, -- Wrap lines at convenient places (`breakat`).
    list = true, -- Show whitespace characters.
    listchars = { -- List of whitespace characters.
      tab = '» ',
      trail = '·',
      nbsp = '␣',
    },
    mouse = 'a', -- Enable mouse mode.
    number = true, -- Show numberline.
    preserveindent = true, -- Preserve indent structure as much as possible.
    pumheight = 10, -- Maximum number of entries in a popup.
    relativenumber = true, -- Show relative numberline.
    ruler = false, -- Disable the default ruler.
    scrolloff = 8, -- Number of lines to leave before/after the cursor when scrolling. Setting a high value keeps the cursor centered.
    shiftround = true, -- Round indent.
    shiftwidth = 2, -- Number of space inserted for indentation.
    showmode = false, -- Disable showing modes in command line.
    sidescrolloff = 8, -- Same as vim.opt.scrolloff but for side scrolling.
    signcolumn = 'yes', -- Always show the sign column.
    smartcase = true, -- Case sensitivie searching.
    smartindent = false, -- Smarter autoindentation.
    smoothscroll = true, -- Enable smooth scrolling.
    splitbelow = true, -- Splits new windows below the current one.
    splitright = true, -- Splits new windows at the right of the current one.
    tabstop = 2, -- Number of space in a tab.
    termguicolors = true, -- Enable 24-bit RGB color in the TUI.
    timeoutlen = 300, -- Shorten key timeout length a little bit for which-key.
    undofile = true, -- Enable persistent undo between session and reboots.
    updatetime = 250, -- Length of time to wait before triggering the plugin.
    virtualedit = 'block', -- Allow going past end of line in visual block mode.
    wildmode = 'longest:full,full', -- Command line completion mode.
  },
}

-- [[ Misc Options ]]
vim.schedule(function() -- Schedule the setting after `UiEnter`.
  vim.opt.clipboard = 'unnamedplus' -- Sync with system clipboard.
end)

vim.opt.shortmess:append { W = true, I = true, c = true, C = true } -- Disable various messages.

-- [[ Apply Variables ]]
for scope, table in pairs(options) do
  for setting, value in pairs(table) do
    vim[scope][setting] = value
  end
end
