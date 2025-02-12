---@type LazySpec
return {
  {
    'folke/lazydev.nvim',
    enabled = true,
    cond = not vim.g.vscode,
    ft = 'lua',
    cmd = { 'LazyDev' },
    opts = {
      -- disable when a .luarc.json file is found
      enabled = function(root_dir) return not vim.uv.fs_stat(root_dir .. '/.luarc.json') end,
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        { path = 'lazy.nvim', words = { 'LazyVim', 'LazySpec' } },
        { path = 'snacks.nvim', words = { 'Snacks', 'snacks' } },
      },
    },
  },
  {
    'Bilal2453/luvit-meta',
    enabled = true,
    cond = not vim.g.vscode,
    lazy = true,
  },
}
