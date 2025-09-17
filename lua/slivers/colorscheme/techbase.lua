local M = {
  name = 'techbase',
  variants = {
    'techbase-hc',
  },
  hl_groups = function()
    local c = require 'techbase.palettes.techbase'

    if vim.g.transparent_bg then
      vim.cmd 'highlight Normal guibg=NONE ctermbg=NONE'
      vim.cmd 'highlight NormalFloat guibg=NONE'
      vim.cmd 'highlight NormalNC guibg=NONE'
      vim.cmd 'highlight FloatBorder guibg=NONE'
      vim.cmd 'highlight FloatTitle guibg=NONE'
      vim.cmd 'highlight WinBar guibg=NONE'
      vim.cmd 'highlight WinBarNC guibg=NONE'
    end

    vim.cmd(string.format('highlight @tag.tsx guifg=%s', c.constant))
    vim.cmd(string.format('highlight @tag.html guifg=%s', c.constant))
    vim.cmd(string.format('highlight @tag.attribute.tsx guifg=%s', c.normal_fg))
    vim.cmd(string.format('highlight @function.call guifg=%s', c.important))
    vim.cmd(string.format('highlight @function.method.call guifg=%s', c.important))
    vim.cmd(string.format('highlight @variable.razor guifg=%s', c.important))
    vim.cmd(string.format('highlight @variable.member.razor guifg=%s', c.keyword))
    vim.cmd(string.format('highlight @markup.heading.1.html guifg=%s', c.normal_fg))
    vim.cmd(
      string.format('highlight SnacksPickerGitStatusModified guifg=%s guibg=%s', c.git_change_fg, c.git_change_bg)
    )
    vim.cmd(string.format('highlight SnacksPickerGitStatusUntracked guifg=%s guibg=%s', c.git_add_fg, c.git_add_bg))

    return require 'slivers.colorscheme._fallback'
  end,
}

return M
