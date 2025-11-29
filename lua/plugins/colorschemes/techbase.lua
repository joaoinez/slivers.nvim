---@type LazySpec
return {
  'mcauley-penney/techbase.nvim',
  enabled = true,
  priority = 1000,
  lazy = Slivers.colorscheme.get_config(ColorSliver.colorschemes, vim.g.colors_name).name ~= 'techbase',
  config = function()
    local colors = require 'techbase.palettes.techbase'

    require('techbase').setup {
      transparent = vim.g.transparent_bg,
      plugin_support = {
        gitsigns = false,
      },
      -- TODO: Move hls from the other techbase file to this one
      hl_overrides = {
        ['WinSeparator'] = { fg = colors.keyword },
        ['RenderMarkdownH1Bg'] = { bg = colors.v_select },
        ['SnacksStatusColumnMark'] = { bg = '#EBCB8B', fg = '#2E3440' },
        ['NeogitPopupSwitchEnabled'] = { fg = colors.error },
        ['DiffText'] = { bg = colors.important, fg = colors.normal_fg },
        ['@tag.tsx'] = { fg = colors.constant },
        ['@tag.html'] = { fg = colors.constant },
        ['@tag.attribute.tsx'] = { fg = colors.normal_fg },
        ['@function.call'] = { fg = colors.important },
        ['@function.method.call'] = { fg = colors.important },
        ['@variable.razor'] = { fg = colors.important },
        ['@variable.member.razor'] = { fg = colors.keyword },
        ['@markup.heading.1.html'] = { fg = colors.normal_fg },
        ['SnacksPickerGitStatusModified'] = { fg = colors.git_change_fg, bg = colors.git_change_bg },
        ['SnacksPickerGitStatusUntracked'] = { fg = colors.git_add_fg, bg = colors.git_add_bg },
      },
    }
  end,
}
