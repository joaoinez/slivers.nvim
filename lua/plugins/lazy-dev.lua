return {
  {
    'folke/lazydev.nvim',
    enabled = false,
    ft = 'lua',
    cmd = 'LazyDev',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
        { path = 'utils', words = { 'SliverUtils' } },
      },
    },
  },
  {
    'Bilal2453/luvit-meta',
    enabled = false,
    lazy = true,
  },
}
