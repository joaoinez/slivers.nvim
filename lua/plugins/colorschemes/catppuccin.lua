---@type LazySpec
return {
  'catppuccin/nvim',
  enabled = true,
  name = 'catppuccin',
  -- priority = 1000,
  lazy = true,
  opts = {
    transparent_background = vim.g.transparent_bg,
    integrations = {
      aerial = true,
      alpha = true,
      blink_cmp = true,
      cmp = true,
      dashboard = true,
      flash = true,
      fzf = true,
      grug_far = true,
      gitsigns = true,
      headlines = true,
      illuminate = true,
      indent_blankline = { enabled = true },
      leap = true,
      lsp_trouble = true,
      mason = true,
      markdown = true,
      mini = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { 'undercurl' },
          hints = { 'undercurl' },
          warnings = { 'undercurl' },
          information = { 'undercurl' },
        },
      },
      navic = { enabled = true, custom_bg = 'lualine' },
      neotest = true,
      neotree = true,
      noice = true,
      notify = false,
      semantic_tokens = true,
      snacks = true,
      telescope = true,
      treesitter = true,
      treesitter_context = true,
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
  },
}
