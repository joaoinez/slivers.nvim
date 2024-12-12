return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'letieu/harpoon-lualine',
  },
  event = 'VeryLazy',
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      vim.o.statusline = ' '
    else
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    -- PERF: we don't need this lualine require madness 🤷
    local lualine_require = require 'lualine_require'
    lualine_require.require = require
    local mocha = require('catppuccin.palettes').get_palette 'mocha'

    local function get_harpoon_indicator(prefix, suffix)
      return function(harpoon_entry)
        local path = {}
        local i = 1
        local matched = harpoon_entry.value:gmatch '([^/]+)'

        if not matched then return 'unknown' end

        for value in matched do
          path[i] = value and value or ''
          i = i + 1
        end

        local trimmed_filename = #path > 1 and path[#path - 1] .. '/' .. path[#path] or path[1]

        return (prefix or '') .. trimmed_filename .. (suffix or '')
      end
    end

    -- Set global lualine
    vim.o.laststatus = vim.g.lualine_laststatus

    local opts = {
      options = {
        theme = 'auto',
        globalstatus = vim.o.laststatus == 3,
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {
            'dashboard',
            'alpha',
            'ministarter',
            'snacks_dashboard',
          },
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },

        lualine_c = {
          {
            'diagnostics',
            symbols = {
              error = ' ',
              warn = ' ',
              info = ' ',
              hint = ' ',
            },
          },
          {
            'filetype',
            icon_only = true,
            padding = { left = 1, right = 0 },
            separator = '',
          },
          {
            'filename',
            symbols = {
              modified = '',
              readonly = '',
            },
            path = 4,
            padding = { left = 0, right = 1 },
          },
        },
        lualine_x = {
          {
            'harpoon2',
            indicators = {
              get_harpoon_indicator(),
              get_harpoon_indicator(),
              get_harpoon_indicator(),
              get_harpoon_indicator(),
            },
            active_indicators = {
              get_harpoon_indicator('[', ']'),
              get_harpoon_indicator('[', ']'),
              get_harpoon_indicator('[', ']'),
              get_harpoon_indicator('[', ']'),
            },
            _separator = '  ',
            color = function() return { fg = mocha.sky } end,
          },
        },
        lualine_y = {
          -- stylua: ignore
          {
            ---@diagnostic disable-next-line: undefined-field
            function() return require("noice").api.status.command.get() end,
            ---@diagnostic disable-next-line: undefined-field
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = function()
              return { fg = mocha.pink }
            end
          },
          -- stylua: ignore
          {
            ---@diagnostic disable-next-line: undefined-field
            function() return require("noice").api.status.mode.get() end,
            ---@diagnostic disable-next-line: undefined-field
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = function()
              return { fg = mocha.lavender }
            end
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = function()
              return { fg = mocha.yellow }
            end
          },
          -- stylua: ignore
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function()
              return { fg = mocha.peach }
            end
          },
          {
            'diff',
            symbols = {
              added = ' ',
              modified = ' ',
              removed = ' ',
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_z = {
          'progress',
          'location',
        },
      },
      extensions = { 'neo-tree', 'lazy' },
    }

    if SliverUtils.lazy.is_available 'trouble.nvim' then
      local trouble = require 'trouble'
      local symbols = trouble.statusline {
        mode = 'symbols',
        groups = {},
        title = false,
        filter = { range = true },
        format = '{kind_icon}{symbol.name:Normal}',
        hl_group = 'lualine_c_normal',
      }
      table.insert(opts.sections.lualine_c, {
        symbols and symbols.get,
        cond = function() return vim.b.trouble_lualine ~= false and symbols.has() end,
      })
    end

    return opts
  end,
}
