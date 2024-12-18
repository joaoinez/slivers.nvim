return {
  'yetone/avante.nvim',
  enabled = true,
  version = false,
  build = 'make',
  event = 'VeryLazy',
  keys = require('plugins.avante.keymaps').keys,
  opts = {
    behaviour = {
      auto_suggestions = true,
    },
    mappings = {
      ---@class AvanteConflictMappings
      diff = {
        ours = 'co',
        theirs = 'ct',
        all_theirs = 'ca',
        both = 'cb',
        cursor = 'cc',
        next = ']x',
        prev = '[x',
      },
      suggestion = {
        accept = '<M-l>',
        next = '<M-]>',
        prev = '<M-[>',
        dismiss = '<C-]>',
      },
      jump = {
        next = ']]',
        prev = '[[',
      },
      submit = {
        normal = '<CR>',
        insert = '<C-s>',
      },
      ask = '<leader>aa',
      edit = '<leader>ae',
      refresh = '<leader>ar',
      focus = '<leader>af',
      clear = '<leader>az',
      toggle = {
        default = '<leader>ta',
        debug = '<leader>ad',
        hint = '<leader>ah',
        suggestion = '<leader>as',
        repomap = '<leader>aR',
      },
      sidebar = {
        apply_all = 'A',
        apply_cursor = 'a',
        switch_windows = '<Tab>',
        reverse_switch_windows = '<S-Tab>',
        remove_file = 'd',
        add_file = '@',
      },
      files = {
        add_current = '<leader>aF',
      },
    },
    provider = 'ollama',
    auto_suggestions_provider = 'ollama',
    vendors = {
      ollama = {
        __inherited_from = 'openai',
        api_key_name = '',
        endpoint = 'http://127.0.0.1:11434/v1',
        model = 'qwen2.5-coder:latest',
      },
    },
  },
}
