return {
  {
    'echasnovski/mini.icons',
    version = false,
    lazy = true,
    opts = {},
  },
  {
    'echasnovski/mini.splitjoin',
    version = false,
    event = 'VeryLazy',
    opts = {},
  },
  {
    'echasnovski/mini.pairs',
    version = false,
    event = 'VeryLazy',
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { 'string' },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    },
  },
  {
    'echasnovski/mini.ai',
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
          i = Slivers.mini.ai_indent, -- indent
          g = Slivers.mini.ai_buffer, -- buffer
          u = ai.gen_spec.function_call(), -- u for "Usage"
          U = ai.gen_spec.function_call { name_pattern = '[%w_]' }, -- without dot in function name
        },
      }
    end,
    config = function(_, opts)
      local utils = require 'utils.init'

      require('mini.ai').setup(opts)

      Slivers.lazy.on_load('which-key.nvim', function()
        vim.schedule(function() Slivers.mini.ai_whichkey(opts) end)
      end)
    end,
  },
  {
    'echasnovski/mini.surround',
    version = false,
    event = 'VeryLazy',
    opts = {},
  },
  {
    'echasnovski/mini.move',
    version = false,
    event = 'VeryLazy',
    opts = {},
  },
  {
    'echasnovski/mini.indentscope',
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = 'User LazyFile',
    opts = function()
      return {
        draw = {
          delay = 0,
          animation = require('mini.indentscope').gen_animation.none(),
        },
        symbol = '│',
        options = { try_as_border = true },
      }
    end,
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'Trouble',
          'alpha',
          'dashboard',
          'fzf',
          'help',
          'lazy',
          'mason',
          'neo-tree',
          'notify',
          'snacks_dashboard',
          'snacks_notif',
          'snacks_terminal',
          'snacks_win',
          'toggleterm',
          'trouble',
          '*oil*',
        },
        callback = function() vim.b.miniindentscope_disable = true end,
      })

      vim.api.nvim_create_autocmd('User', {
        pattern = 'SnacksDashboardOpened',
        callback = function(data) vim.b[data.buf].miniindentscope_disable = true end,
      })
    end,
  },
  {
    'echasnovski/mini.map',
    version = false,
    keys = {
      { '<leader>tm', function() require('mini.map').toggle() end, desc = 'Minimap' },
    },
    opts = function()
      local map = require 'mini.map'

      return {
        integrations = {
          map.gen_integration.diff(),
          map.gen_integration.diagnostic(),
          map.gen_integration.gitsigns(),
        },
        symbols = {
          encode = map.gen_encode_symbols.dot '4x2',
          scroll_line = '',
          scroll_view = '',
        },
        window = {
          focusable = false,
          show_integration_count = false,
          width = 25,
          winblend = 0,
          zindex = 25,
        },
      }
    end,
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'Trouble',
          'alpha',
          'dashboard',
          'fzf',
          'help',
          'lazy',
          'mason',
          'neo-tree',
          'notify',
          'snacks_dashboard',
          'snacks_notif',
          'snacks_terminal',
          'snacks_win',
          'toggleterm',
          'trouble',
        },
        callback = function() vim.b.minimap_disable = true end,
      })

      vim.api.nvim_create_autocmd('User', {
        pattern = 'SnacksDashboardOpened',
        callback = function(data) vim.b[data.buf].minimap_disable = true end,
      })

      vim.api.nvim_create_autocmd('User', {
        pattern = 'LazyFile',
        desc = 'Open mini.map on file open',
        callback = function() vim.schedule(require('mini.map').open) end,
      })
    end,
  },
}
