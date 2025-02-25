---@type LazySpec
return {
  'nvim-treesitter/nvim-treesitter',
  enabled = true,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    {
      'hiphish/rainbow-delimiters.nvim',
      config = function()
        require('rainbow-delimiters.setup').setup {
          query = {
            javascript = 'rainbow-parens',
            typescript = 'rainbow-parens',
            tsx = 'rainbow-parens',
            lua = 'rainbow-blocks',
          },
        }
      end,
    },
    {
      'bezhermoso/tree-sitter-ghostty',
      build = 'make nvim_install',
    },
  },
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePost', 'VeryLazy' },
  cmd = {
    'TSBufDisable',
    'TSBufEnable',
    'TSBufToggle',
    'TSDisable',
    'TSEnable',
    'TSToggle',
    'TSInstall',
    'TSInstallInfo',
    'TSInstallSync',
    'TSModuleInfo',
    'TSUninstall',
    'TSUpdate',
    'TSUpdateSync',
  },
  opts = {
    ensure_installed = LangSliver.get_highlighters(),
    auto_install = false,
    highlight = {
      enable = true,
      disable = function(_, bufnr) return vim.b[bufnr].large_buf end,
      additional_vim_regex_highlighting = { 'ruby' },
    },
    matchup = {
      enable = true,
      enable_quotes = true,
      disable = function(_, bufnr) return vim.b[bufnr].large_buf end,
    },
    indent = {
      enable = true,
      disable = { 'ruby' },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'gnn', -- in normal mode, start incremental selection
        node_incremental = 'grn', -- in visual mode, increment to the upper named parent
        scope_incremental = 'grc', -- in visual mode, increment to the upper scope
        node_decremental = 'grm', -- in visual mode, decrement to the previous named node
      },
    },
  },
}
