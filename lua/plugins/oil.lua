---@type LazySpec
return {
  'stevearc/oil.nvim',
  enabled = true,
  cmd = { 'Oil' },
  keys = {
    {
      '<leader>fE',
      '<cmd>Oil<cr>',
      desc = 'File Explorer (oil)',
    },
  },
  opts = function()
    local detail = false

    return {
      default_file_explorer = false,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ['q'] = { 'actions.close', mode = 'n' },
        ['gd'] = {
          desc = 'Toggle file detail view',
          callback = function()
            detail = not detail
            if detail then
              require('oil').set_columns { 'icon', 'permissions', 'size', 'mtime' }
            else
              require('oil').set_columns { 'icon' }
            end
          end,
        },
      },
    }
  end,
}
