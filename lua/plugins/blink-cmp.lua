---@type LazySpec
return {
  'saghen/blink.cmp',
  enabled = true,
  cond = not vim.g.vscode,
  version = vim.fn.has 'mac' == 1 and '*' or '1.*',
  dependencies = {
    { 'saghen/blink.compat', version = vim.fn.has 'mac' == 1 and '*' or '2.*', opts = {} },
    'L3MON4D3/LuaSnip',
  },
  build = vim.fn.has 'mac' == 1 and 'cargo build --release' or nil,
  event = 'InsertEnter',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
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
      nerd_font_variant = 'mono',
      kind_icons = IconSliver.cmp,
    },
    cmdline = { enabled = false },
    completion = {
      documentation = { auto_show = true },
      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },
    },
    sources = {
      default = {
        'lsp',
        'path',
        'snippets',
        'buffer',
        'html-css',
      },
      per_filetype = {
        lua = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
      },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
        markdown = {
          name = 'RenderMarkdown',
          module = 'render-markdown.integ.blink',
        },
        ['html-css'] = {
          name = 'html-css',
          module = 'blink.compat.source',
        },
      },
    },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
    snippets = { preset = 'luasnip' },
  },
  opts_extend = { 'sources.default' },
}
