---@type LazySpec
return {
  'catppuccin/nvim',
  enabled = true,
  name = 'catppuccin',
  priority = 1000,
  lazy = false,
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
        return {
          LineNr = { fg = colors.overlay1 },
        }
      end,
    },
    init = function() ColorSliver.apply() end,
  },
}
