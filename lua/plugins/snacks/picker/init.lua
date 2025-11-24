---@diagnostic disable: missing-fields

---@type snacks.picker.Config
local M = {
  enabled = true,
  ui_select = true,
  win = {
    input = {
      keys = {
        ['<c-q>'] = { 'trouble_open', mode = { 'n', 'i' } },
        ['<c-t>'] = { 'trouble_add', mode = { 'n', 'i' } },
        ['<a-s>'] = { 'flash', mode = { 'n', 'i' } },
        ['s'] = { 'flash' },
        ['<a-c>'] = { 'toggle_cwd', mode = { 'n', 'i' } },
        ['<a-t>'] = { 'tab', mode = { 'n', 'i' } },
      },
    },
  },
  actions = {
    trouble_open = function(...) return require('trouble.sources.snacks').actions.trouble_open.action(...) end,
    trouble_add = function(...) return require('trouble.sources.snacks').actions.trouble_add.action(...) end,
    flash = function(picker)
      require('flash').jump {
        pattern = '^',
        label = { after = { 0, 0 } },
        search = {
          mode = 'search',
          exclude = {
            function(win) return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'snacks_picker_list' end,
          },
        },
        action = function(match)
          local idx = picker.list:row2idx(match.pos[1])
          picker.list:_move(idx, true, true)
        end,
      }
    end,
  },
  previewers = {
    git = {
      native = true,
    },
  },
}

return M
