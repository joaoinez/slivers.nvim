---@type LazySpec
return {
  'saghen/blink.cmp',
  enabled = true,
  dependencies = {
    {
      'saghen/blink.compat',
      version = '*',
      opts = {},
    },
    'rafamadriz/friendly-snippets',
  },
  version = '*',
  event = 'InsertEnter',
  opts = {
    keymap = {
      preset = 'enter',
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
      ['<C-p>'] = { 'snippet_backward', 'fallback' },
      ['<C-n>'] = { 'snippet_forward', 'fallback' },
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
      -- list = {
      --   selection = 'manual',
      -- },
      -- trigger = {
      --   show_on_insert_on_trigger_character = false,
      -- },
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
      cmdline = {},
    },
  },
  opts_extend = { 'sources.default' },
}
