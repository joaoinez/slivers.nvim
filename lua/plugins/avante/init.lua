return {
  'yetone/avante.nvim',
  enabled = false,
  version = false,
  dependencies = {
    {
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
        },
      },
    },
  },
  build = 'make',
  event = 'VeryLazy',
  keys = require('plugins.avante.keymaps').keys,
  opts = {
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
      -- NOTE: The following will be safely set by avante.nvim
      ask = '<leader>aa',
      edit = '<leader>ae',
      refresh = '<leader>ar',
      focus = '<leader>af',
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
        add_current = '<leader>aF', -- Add current buffer to selected files
      },
    },
    provider = 'qwen2.5-coder:latest',
    auto_suggestions_provider = 'qwen2.5-coder:1.5b',
    vendors = {
      ['qwen2.5-coder:latest'] = {
        __inherited_from = 'openai',
        api_key_name = '',
        endpoint = 'http://127.0.0.1:11434/v1',
        model = 'qwen2.5-coder:latest',
      },
      ['qwen2.5-coder:1.5b'] = {
        __inherited_from = 'openai',
        api_key_name = '',
        endpoint = 'http://127.0.0.1:11434/v1',
        model = 'qwen2.5-coder:1.5b',
      },
    },
  },
}
