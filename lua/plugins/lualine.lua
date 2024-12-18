---@type LazySpec
return {
  'nvim-lualine/lualine.nvim',
  enabled = true,
  dependencies = {
    'letieu/harpoon-lualine',
  },
  event = 'VeryLazy',
  opts = function()
    -- PERF: we don't need this lualine require madness 🤷
    local lualine_require = require 'lualine_require'
    lualine_require.require = require
    local catppuccin = require('catppuccin.palettes').get_palette 'mocha'

    local clients_lsp = function()
      local bufnr = vim.api.nvim_get_current_buf()

      local clients = Slivers.lsp.get_clients { bufnr = bufnr }
      if next(clients) == nil then return '' end

      local c = {}
      for _, client in pairs(clients) do
        table.insert(c, IconSliver.lualine.lsp[client.name] or client.name)
      end
      return table.concat(c, ' ')
    end

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
        section_separators = IconSliver.lualine.section_separators,
        component_separators = IconSliver.lualine.component_separators,
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
              error = IconSliver.diagnostics.error .. ' ',
              warn = IconSliver.diagnostics.warn .. ' ',
              info = IconSliver.diagnostics.info .. ' ',
              hint = IconSliver.diagnostics.hint .. ' ',
            },
          },
          {
            'filename',
            symbols = IconSliver.lualine.file,
            path = 4,
            separator = '',
          },
          {
            'filetype',
            colored = true,
            icon_only = true,
            padding = { left = 0, right = 0 },
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
            color = function() return { fg = catppuccin.sky } end,
          },
        },
        lualine_y = {
          {
            ---@diagnostic disable-next-line: undefined-field
            function() return require('noice').api.status.mode.get() end,
            ---@diagnostic disable-next-line: undefined-field
            cond = function() return package.loaded['noice'] and require('noice').api.status.mode.has() end,
            color = function() return { fg = catppuccin.lavender } end,
          },
          {
            function() return '  ' .. require('dap').status() end,
            cond = function() return package.loaded['dap'] and require('dap').status() ~= '' end,
            color = function() return { fg = catppuccin.yellow } end,
          },
          {
            'diff',
            symbols = IconSliver.lualine.diff,
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
          {
            clients_lsp,
            color = function() return { fg = catppuccin.pink } end,
          },
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
            color = function() return { fg = catppuccin.peach } end,
          },
        },
        lualine_z = {
          'location',
          'progress',
        },
      },
      extensions = {
        'lazy',
        'man',
        'mason',
        'nvim-dap-ui',
        'oil',
        'overseer',
        'toggleterm',
        'trouble',
      },
    }

    if Slivers.lazy.is_available 'trouble.nvim' then
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
        cond = function() return symbols.has() end,
      })
    end

    return opts
  end,
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      vim.o.statusline = ' '
    else
      vim.o.laststatus = 0
    end
  end,
}
