---@type LazySpec
return {
  'saghen/blink.cmp',
  enabled = true,
  cond = not vim.g.vscode,
  dependencies = {
    { 'saghen/blink.compat', version = '*', opts = {} },
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      dependencies = {
        'rafamadriz/friendly-snippets',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
          require('luasnip.loaders.from_vscode').lazy_load { paths = { vim.fn.stdpath 'config' .. '/snippets' } }

          local extends = {
            typescript = { 'tsdoc' },
            javascript = { 'jsdoc' },
            lua = { 'luadoc' },
            python = { 'pydoc' },
            rust = { 'rustdoc' },
            cs = { 'csharpdoc' },
            java = { 'javadoc' },
            c = { 'cdoc' },
            cpp = { 'cppdoc' },
            php = { 'phpdoc' },
            kotlin = { 'kdoc' },
            ruby = { 'rdoc' },
            sh = { 'shelldoc' },
          }
          -- friendly-snippets - enable standardized comments snippets
          for ft, snips in pairs(extends) do
            require('luasnip').filetype_extend(ft, snips)
          end
        end,
      },
    },
  },
  version = '*',
  event = 'InsertEnter',
  opts = {
    snippets = { preset = 'luasnip' },
    keymap = {
      preset = 'none',
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide', 'fallback' },
      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-p>'] = { 'snippet_backward', 'fallback' },
      ['<C-n>'] = { 'snippet_forward', 'fallback' },
      ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },
    },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = 'mono',
      kind_icons = IconSliver.cmp,
    },
    completion = {
      accept = {
        auto_brackets = {
          enabled = false,
        },
      },
      menu = {
        auto_show = function(ctx)
          return ctx.mode ~= 'cmdline' or not vim.tbl_contains({ '/', '?' }, vim.fn.getcmdtype())
        end,
        draw = {
          treesitter = { 'lsp' },
          columns = {
            { 'label', 'label_description', gap = 1 },
            { 'kind_icon', 'kind', gap = 1 },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },
    },
    sources = {
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
        markdown = {
          name = 'RenderMarkdown',
          module = 'render-markdown.integ.blink',
        },
        avante_commands = {
          name = 'avante_commands',
          module = 'blink.compat.source',
          score_offset = 90, -- show at a higher priority than lsp
          opts = {},
        },
        avante_files = {
          name = 'avante_commands',
          module = 'blink.compat.source',
          score_offset = 100, -- show at a higher priority than lsp
          opts = {},
        },
        avante_mentions = {
          name = 'avante_mentions',
          module = 'blink.compat.source',
          score_offset = 1000, -- show at a higher priority than lsp
          opts = {},
        },
        cmdline = {
          enabled = false,
        },
        buffer = {
          opts = {
            get_bufnrs = function()
              return vim.tbl_filter(function(bufnr) return vim.bo[bufnr].buftype == '' end, vim.api.nvim_list_bufs())
            end,
          },
        },
      },
      default = {
        'lazydev',
        'lsp',
        'path',
        'snippets',
        'buffer',
        'markdown',
        'avante_commands',
        'avante_mentions',
        'avante_files',
      },
    },
  },
  opts_extend = { 'sources.default' },
}
