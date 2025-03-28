-- [[ Globals ]]
vim.g.mapleader = ' ' -- Set leader key.
vim.g.maplocalleader = ' ' -- Set default local leader key.

if not vim.g.vscode then
  -- Source globals from config file
  local path = vim.fn.stdpath 'config' .. '/.slivers.json'
  if Slivers.misc.file_exists(path) then
    local config = vim.json.decode(Slivers.misc.read_file(path))

    for global, value in pairs(config) do
      vim.g[global] = value
    end
  else
    local default_config = {
      ai_model = 'claude', -- Set default ai model. Use `-local` to use local models and `-dual` to use dual boost.
      transparent_bg = true, -- Set transparent background.
      mode_len = 3, -- Set mode text length; 0 is Neovim's default.
      lualine_borders = true, -- Set lualine rounded borders.
      ai_local = false, -- Whether to use local ai models.
      dark_mode = true, -- Set background dark mode.
      trouble_lualine = true, -- Show the current document symbols location from Trouble in lualine.
      dev = false, -- Enable or disable dev related plugins.
      server = false, -- Enable or disable server related plugins.
    }

    Slivers.misc.write_file(path, vim.json.encode(default_config))

    for global, value in pairs(default_config) do
      vim.g[global] = value
    end
  end

  -- [[ Options ]]
  vim.o.background = vim.g.dark_mode and 'dark' or 'light' -- Set background to either dark or light.
  vim.o.breakindent = true -- Wrap indent to match line start.
  vim.o.cmdheight = 0 -- Hide command line unless needed.
  vim.o.colorcolumn = '80' -- Show character limit vertical bar.
  vim.opt.completeopt = { -- Options for insert mode completion.
    'menu',
    'menuone',
    'noselect',
  }
  vim.o.copyindent = true -- Copy the previous indentation on autoindenting.
  vim.o.conceallevel = 2 -- Hide markup symbols for bold and italic, but not markers with substitutions.
  vim.o.confirm = true -- Confirm to save changes before exiting modified buffer.
  vim.o.cursorline = true -- Highlight the text line of the cursor.
  vim.o.expandtab = true -- Enable the use of space in tab.
  vim.opt.fillchars = { -- Characters to fill the statuslines, vertical separators and special lines in the window.
    foldopen = '',
    foldclose = '',
    fold = ' ',
    foldsep = ' ',
    diff = '╱',
    eob = ' ',
  }
  vim.o.foldcolumn = '1' -- Show fold column.
  vim.o.foldenable = true -- Enable folds.
  vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- Folding based on treesitter.
  vim.o.foldmethod = 'expr' -- Set fold method to expression.
  vim.o.foldtext = '' -- Remove fold text.
  vim.o.foldlevel = 99 -- Set fold level to highest value.
  vim.o.foldlevelstart = 99 -- Start with all code unfolded.
  vim.o.guicursor = 'n-c-sm:block,\z
i-ci-ve:ver25-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,\z
v-r-cr-o:hor20' -- Cursor styling
  vim.o.ignorecase = true -- Case insensitive searching.
  vim.o.inccommand = 'split' -- Show incremental substitute in a preview window.
  vim.o.infercase = true -- Infer cases in keyword completion.
  vim.o.laststatus = 3 -- Show global status.
  vim.o.linebreak = true -- Wrap lines at convenient places (`breakat`).
  vim.o.list = true -- Show whitespace characters.
  vim.opt.listchars = { -- List of whitespace characters.
    tab = '» ',
    trail = '·',
    nbsp = '␣',
  }
  vim.o.mouse = 'a' -- Enable mouse mode.
  vim.o.number = true -- Show numberline.
  vim.o.preserveindent = true -- Preserve indent structure as much as possible.
  vim.o.pumheight = 10 -- Maximum number of entries in a popup.
  vim.o.relativenumber = true -- Show relative numberline.
  vim.o.ruler = false -- Disable the default ruler.
  vim.o.scrolloff = 10 -- Number of lines to leave before/after the cursor when scrolling. Setting a high value keeps the cursor centered.
  vim.o.shiftround = true -- Round indent.
  vim.o.shiftwidth = 2 -- Number of space inserted for indentation.
  vim.opt.shortmess:append { W = true, I = true, c = true, C = true } -- Disable various messages.
  vim.o.showmode = false -- Disable showing modes in command line.
  vim.o.sidescrolloff = 8 -- Same as vim.o.scrolloff but for side scrolling.
  vim.o.signcolumn = 'yes' -- Always show the sign column.
  vim.o.smartcase = true -- Case sensitivie searching.
  vim.o.smartindent = false -- Smarter autoindentation.
  vim.o.smoothscroll = true -- Enable smooth scrolling.
  vim.o.splitbelow = true -- Splits new windows below the current one.
  vim.o.splitright = true -- Splits new windows at the right of the current one.
  vim.o.tabstop = 2 -- Number of space in a tab.
  vim.o.termguicolors = true -- Enable 24-bit RGB color in the TUI.
  vim.o.timeoutlen = 300 -- Shorten key timeout length a little bit for which-key.
  vim.o.updatetime = 250 -- Length of time to wait before triggering the plugin.
  vim.o.virtualedit = 'block' -- Allow going past end of line in visual block mode.
  vim.o.wrap = true -- Enable line wraping.
  vim.o.wildmode = 'longest:full,full' -- Command line completion mode.
end

vim.o.undofile = true -- Enable persistent undo between session and reboots.

vim.schedule(function() -- Schedule the setting after `UiEnter`.
  vim.o.clipboard = 'unnamedplus' -- Sync with system clipboard.
end)
