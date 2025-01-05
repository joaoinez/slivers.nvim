---@type LazySpec
return {
  'saghen/blink.cmp',
  enabled = true,
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = 'v0.*',
  event = 'InsertEnter',
  opts = {
    keymap = {
      preset = 'enter',
      ['<Tab>'] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.snippet_forward()
          else
            return cmp.select_next()
          end
        end,
        'fallback',
      },
      ['<S-Tab>'] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.snippet_backward()
          else
            return cmp.select_prev()
          end
        end,
        'fallback',
      },
    },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = 'mono',
      kind_icons = IconSliver.cmp,
    },
    signature = {
      enabled = true,
    },
    completion = {
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
      },
      default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer', 'markdown' },
      cmdline = {},
    },
  },
  opts_extend = { 'sources.default' },
}
