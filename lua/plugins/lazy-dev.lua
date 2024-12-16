return {
  {
    'folke/lazydev.nvim',
    enabled = true,
    ft = 'lua',
    cmd = 'LazyDev',
    opts = {
      -- disable when a .luarc.json file is found
      enabled = function(root_dir) return not vim.uv.fs_stat(root_dir .. '/.luarc.json') end,
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        { path = 'utils', words = { 'Slivers' } },
        { path = 'configs.lang', words = { 'LangSliver' } },
        { path = 'configs.icons', words = { 'IconSliver' } },
      },
    },
  },
  {
    'Bilal2453/luvit-meta',
    enabled = true,
    lazy = true,
  },
}
