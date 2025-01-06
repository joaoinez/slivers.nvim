---@type LazySpec
return {
  'echasnovski/mini.ai',
  enabled = true,
  version = false,
  event = 'VeryLazy',
  opts = function()
    local ai = require 'mini.ai'

    return {
      n_lines = 500,
      custom_textobjects = {
        o = ai.gen_spec.treesitter { -- code block
          a = { '@block.outer', '@conditional.outer', '@loop.outer' },
          i = { '@block.inner', '@conditional.inner', '@loop.inner' },
        },
        f = ai.gen_spec.treesitter { a = '@function.outer', i = '@function.inner' }, -- function
        c = ai.gen_spec.treesitter { a = '@class.outer', i = '@class.inner' }, -- class
        t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' }, -- tags
        d = { '%f[%d]%d+' }, -- digits
        e = { -- Word with case
          { '%u[%l%d]+%f[^%l%d]', '%f[%S][%l%d]+%f[^%l%d]', '%f[%P][%l%d]+%f[^%l%d]', '^[%l%d]+%f[^%l%d]' },
          '^().*()$',
        },
        g = require('plugins.mini.utils').ai_buffer, -- buffer
        u = ai.gen_spec.function_call(), -- u for "Usage"
        U = ai.gen_spec.function_call { name_pattern = '[%w_]' }, -- without dot in function name
      },
    }
  end,
  config = function(_, opts)
    require('mini.ai').setup(opts)

    Slivers.lazy.on_load('which-key.nvim', function()
      vim.schedule(function() require('plugins.mini.utils').ai_whichkey(opts) end)
    end)
  end,
}
