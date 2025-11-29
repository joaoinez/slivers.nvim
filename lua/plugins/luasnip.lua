---@type LazySpec
return {
  'L3MON4D3/LuaSnip',
  enabled = true,
  cond = not vim.g.vscode,
  version = 'v2.*',
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  build = vim.fn.has 'win32' ~= 0 and 'make install_jsregexp' or nil,
  lazy = true,
  config = function()
    local types = require 'luasnip.util.types'

    require('luasnip').config.setup()

    -- Set up filetype extensions BEFORE lazy loading
    -- see the list of frameworks in: https://github.com/rafamadriz/friendly-snippets/tree/main/snippets/frameworks
    -- and search for possible languages in: https://github.com/rafamadriz/friendly-snippets/blob/main/package.json
    require('luasnip').filetype_extend('typescript', { 'tsdoc' })
    require('luasnip').filetype_extend('javascript', { 'jsdoc' })
    require('luasnip').filetype_extend('lua', { 'luadoc' })
    require('luasnip').filetype_extend('python', { 'pydoc' })
    require('luasnip').filetype_extend('rust', { 'rustdoc' })
    require('luasnip').filetype_extend('csharp', { 'csharpdoc' })
    require('luasnip').filetype_extend('cs', { 'csharpdoc' })
    require('luasnip').filetype_extend('razor', { 'csharpdoc', 'html' })
    require('luasnip').filetype_extend('java', { 'javadoc' })
    require('luasnip').filetype_extend('c', { 'cdoc' })
    require('luasnip').filetype_extend('cpp', { 'cppdoc' })
    require('luasnip').filetype_extend('php', { 'phpdoc' })
    require('luasnip').filetype_extend('kotlin', { 'kdoc' })
    require('luasnip').filetype_extend('ruby', { 'rdoc' })
    require('luasnip').filetype_extend('sh', { 'shelldoc' })

    vim.tbl_map(
      function(type) require('luasnip.loaders.from_' .. type).lazy_load() end,
      { 'vscode', 'snipmate', 'lua' }
    )

    -- Load custom snippets from config directory
    require('luasnip.loaders.from_vscode').lazy_load {
      paths = { vim.fn.stdpath 'config' .. '/snippets' },
    }

    -- Load project-specific snippets if available
    pcall(function()
      local git_root = Snacks.git.get_root()
      if git_root then
        require('luasnip.loaders.from_vscode').lazy_load {
          paths = { git_root .. '/.vscode' },
        }
      end
    end)
  end,
}
