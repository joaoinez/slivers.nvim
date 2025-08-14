---@type LazySpec
return {
  'catppuccin/nvim',
  enabled = true,
  name = 'catppuccin',
  priority = 1000,
  lazy = Slivers.colorscheme.get_config(ColorSliver.colorschemes, vim.g.colors_name).name ~= 'catppuccin',
  opts = {
    transparent_background = vim.g.transparent_bg,
    integrations = {
      avante = {
        enabled = false,
        windows_sidebar_header_rounded = true,
      },
      blink_cmp = true,
      diffview = true,
      grug_far = true,
      lsp_trouble = true,
      mason = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { 'undercurl' },
          hints = { 'undercurl' },
          warnings = { 'undercurl' },
          information = { 'undercurl' },
        },
      },
      neotest = true,
      noice = true,
      overseer = true,
      semantic_tokens = true,
      snacks = {
        enabled = true,
        -- indent_scope_color = '', -- catppuccin color (eg. `lavender`) Default: text
      },
      which_key = true,
    },
    highlight_overrides = {
      all = function(colors)
        local makeDiagnosticColor = function(color)
          local c = require 'slivers.lib.color'
          return { fg = color, bg = c(color):blend(colors.base, 0.95):to_hex() }
        end

        return {
          LineNr = { fg = colors.overlay1 },

          DiagnosticVirtualTextHint = makeDiagnosticColor(colors.teal),
          DiagnosticVirtualTextInfo = makeDiagnosticColor(colors.teal),
          DiagnosticVirtualTextWarn = makeDiagnosticColor(colors.yellow),
          DiagnosticVirtualTextError = makeDiagnosticColor(colors.red),
        }
      end,
    },
    custom_highlights = function(colors)
      return {
        WinSeparator = { fg = colors.flamingo },
      }
    end,
  },
}
