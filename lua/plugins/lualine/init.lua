---@type LazySpec
return {
  'nvim-lualine/lualine.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  event = 'VeryLazy',
  opts = function()
    -- PERF: we don't need this lualine require madness 🤷
    local lualine_require = require 'lualine_require'
    lualine_require.require = require

    local utils = require 'plugins.lualine.utils'
    local get_color = utils.get_color

    local lsp_clients = require 'plugins.lualine.components.lsp-clients'
    local ai_model = require 'plugins.lualine.components.ai_model'
    local treesitter = require 'plugins.lualine.components.treesitter'

    -- Set global lualine
    vim.o.laststatus = vim.g.lualine_laststatus

    -- Transparent Lualine
    local auto_theme = require 'lualine.themes.auto'
    if vim.g.transparent_bg then
      if auto_theme.inactive and auto_theme.inactive.c then auto_theme.inactive.c.bg = 'none' end
      if auto_theme.visual and auto_theme.visual.c then auto_theme.visual.c.bg = 'none' end
      if auto_theme.replace and auto_theme.replace.c then auto_theme.replace.c.bg = 'none' end
      if auto_theme.normal and auto_theme.normal.c then auto_theme.normal.c.bg = 'none' end
      if auto_theme.insert and auto_theme.insert.c then auto_theme.insert.c.bg = 'none' end
      if auto_theme.command and auto_theme.command.c then auto_theme.command.c.bg = 'none' end
    end

    local opts = {
      options = {
        theme = auto_theme,
        globalstatus = vim.o.laststatus == 3,
        section_separators = IconSliver.lualine.section_separators(),
        component_separators = IconSliver.lualine.component_separators(),
        disabled_filetypes = { statusline = { 'snacks_dashboard' } },
      },
      sections = {
        lualine_a = {
          {
            'mode',
            fmt = function(str) return vim.g.mode_len > 0 and str:sub(1, vim.g.mode_len) or str end,
            separator = {
              left = IconSliver.lualine.section_separators().right,
              right = IconSliver.lualine.section_separators().left,
            },
          },
        },
        lualine_b = {
          'branch',
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
        },
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
            'filetype',
            colored = true,
            icon_only = true,
            separator = '',
            padding = { left = 1, right = 0 },
          },
          {
            'filename',
            symbols = IconSliver.lualine.file,
            path = 4,
            padding = { left = 0, right = 1 },
          },
        },
        lualine_x = {
          {
            ai_model.init,
            icon = ai_model.icon(),
            color = { fg = ai_model.color() },
          },
        },
        lualine_y = {
          {
            ---@diagnostic disable-next-line: undefined-field
            function() return require('noice').api.status.mode.get() end,
            ---@diagnostic disable-next-line: undefined-field
            cond = function() return package.loaded['noice'] and require('noice').api.status.mode.has() end,
            color = get_color 'Macro',
          },
          {
            function() return '  ' .. require('dap').status() end,
            cond = function() return package.loaded['dap'] and require('dap').status() ~= '' end,
            color = get_color 'Stop',
          },
          {
            treesitter,
            color = get_color 'Lsp',
          },
          {
            lsp_clients,
            color = get_color 'Lsp',
          },
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
            color = get_color 'Lazy',
          },
        },
        lualine_z = {
          'location',
          { 'progress', separator = { left = '', right = IconSliver.lualine.section_separators().left } },
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

    if vim.g.trouble_lualine and Slivers.lazy.is_available 'trouble.nvim' then
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
