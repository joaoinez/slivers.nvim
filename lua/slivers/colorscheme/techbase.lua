local M = {
  name = 'techbase',
  globals = function()
    local trouble_lualine = vim.g.trouble_lualine

    if not vim.g.transparent_bg then trouble_lualine = false end

    return {
      lualine_borders = false,
      trouble_lualine = trouble_lualine,
    }
  end,
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
    vim.cmd(string.format('highlight @tag.attribute.tsx guifg=%s', c.normal_fg))
    vim.cmd(string.format('highlight @function.call guifg=%s', c.important))
    vim.cmd(string.format('highlight @function.method.call guifg=%s', c.important))
    vim.cmd(
      string.format('highlight SnacksPickerGitStatusModified guifg=%s guibg=%s', c.git_change_fg, c.git_change_bg)
    )
    vim.cmd(string.format('highlight SnacksPickerGitStatusUntracked guifg=%s guibg=%s', c.git_add_fg, c.git_add_bg))
    vim.cmd(string.format('highlight WinSeparator guifg=%s', c.keyword))

    return require 'slivers.colorscheme._fallback'
  end,
}

return M
