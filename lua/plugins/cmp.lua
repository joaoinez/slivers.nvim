---@diagnostic disable: missing-fields

return {
  'hrsh7th/nvim-cmp',
  enabled = false,
  event = 'InsertEnter',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then return end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        {
          'rafamadriz/friendly-snippets',
          config = function() require('luasnip.loaders.from_vscode').lazy_load() end,
        },
      },
    },
    { 'roobert/tailwindcss-colorizer-cmp.nvim', opts = {} },
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'

    local kind_icons = {
      Array = '',
      Boolean = '󰨙',
      Class = '',
      Codeium = '󰘦',
      Color = '',
      Control = '',
      Collapsed = '',
      Constant = '󰏿',
      Constructor = '',
      Copilot = '',
      Enum = '',
      EnumMember = '',
      Event = '',
      Field = '',
      File = '',
      Folder = '',
      Function = '󰊕',
      Interface = '',
      Key = '',
      Keyword = '',
      Method = '󰊕',
      Module = '',
      Namespace = '󰦮',
      Null = '',
      Number = '󰎠',
      Object = '',
      Operator = '',
      Package = '',
      Property = '',
      Reference = '',
      Snippet = '',
      String = '',
      Struct = '󰆼',
      Supermaven = '',
      TabNine = '󰏚',
      Text = '',
      TypeParameter = '',
      Unit = '',
      Value = '',
      Variable = '󰀫',
    }

    local format_kinds = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
      -- Source
      vim_item.menu = ({
        -- buffer = '[Buffer]',
        -- nvim_lsp = '[LSP]',
        -- luasnip = '[LuaSnip]',
        -- nvim_lua = '[Lua]',
        -- latex_symbols = '[LaTeX]',
      })[entry.source.name]
      return vim_item
    end

    luasnip.config.setup {}

    cmp.setup {
      performance = {
        debounce = 0, -- default is 60ms
        throttle = 0, -- default is 30ms
      },
      formatting = {
        format = function(entry, item)
          format_kinds(entry, item) -- add icons
          return require('tailwindcss-colorizer-cmp').formatter(entry, item)
        end,
      },
      snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
      },
      completion = { completeopt = 'menu,menuone,noinsert' },
      mapping = cmp.mapping.preset.insert {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-y>'] = cmp.mapping.confirm { select = true },
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-c>'] = cmp.mapping.complete(),
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then luasnip.expand_or_jump() end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then luasnip.jump(-1) end
        end, { 'i', 's' }),
      },
      sources = {
        {
          name = 'lazydev',
          group_index = 0,
        },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer' },
      },
    }
  end,
}
