return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  event = { 'User LazyFile', 'VeryLazy' },
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
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true },
    matchup = {
      enable = true,
      enable_quotes = true,
    },
  },
}
