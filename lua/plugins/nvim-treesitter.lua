return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  -- TODO: See why this isn't working
  --
  -- event = { 'User LazyFile', 'VeryLazy' },
  event = { 'BufRead', 'VeryLazy' },
  lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
  -- dependencies = {
  --   "windwp/nvim-ts-autotag",
  --   "nvim-treesitter/nvim-treesitter-textobjects",
  --   "JoosepAlviste/nvim-ts-context-commentstring",
  -- },
  opts = {
    ensure_installed = require('config.lang').get_highlighters(),
    auto_install = false,
    highlight = {
      enable = true,
      disable = function(_, bufnr) return vim.b[bufnr].large_buf end,
      -- additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<C-space>',
        node_incremental = '<C-space>',
        scope_incremental = false,
        node_decremental = '<bs>',
      },
    },
    matchup = {
      enable = true,
      enable_quotes = true,
    },
  },
}
