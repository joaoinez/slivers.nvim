return {
  'nvim-telescope/telescope.nvim',
  enabled = not not vim.g.dev,
  cond = not vim.g.vscode,
  version = false,
  dependencies = {
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function() return vim.fn.executable 'make' == 1 end,
    },
  },
  cmd = { 'Telescope' },
  opts = function()
    local actions = require 'telescope.actions'

    local open_with_trouble = function(...) return require('trouble.sources.telescope').open(...) end

    local function find_command()
      if 1 == vim.fn.executable 'rg' then
        return { 'rg', '--files', '--color', 'never', '-g', '!.git' }
      elseif 1 == vim.fn.executable 'fd' then
        return { 'fd', '--type', 'f', '--color', 'never', '-E', '.git' }
      elseif 1 == vim.fn.executable 'fdfind' then
        return { 'fdfind', '--type', 'f', '--color', 'never', '-E', '.git' }
      elseif 1 == vim.fn.executable 'find' and vim.fn.has 'win32' == 0 then
        return { 'find', '.', '-type', 'f' }
      elseif 1 == vim.fn.executable 'where' then
        return { 'where', '/r', '.', '*' }
      end
    end

    return {
      defaults = {
        prompt_prefix = ' ',
        selection_caret = ' ',
        sorting_strategy = 'ascending',
        layout_config = {
          prompt_position = 'top',
        },
        -- open files in the first window that is an actual file.
        -- use the current window if no other window is available.
        get_selection_window = function()
          local wins = vim.api.nvim_list_wins()
          table.insert(wins, 1, vim.api.nvim_get_current_win())
          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].buftype == '' then return win end
          end
          return 0
        end,
        mappings = {
          i = {
            ['<c-t>'] = open_with_trouble,
            ['<a-t>'] = open_with_trouble,
            ['<C-Down>'] = actions.cycle_history_next,
            ['<C-Up>'] = actions.cycle_history_prev,
            ['<C-f>'] = actions.preview_scrolling_down,
            ['<C-b>'] = actions.preview_scrolling_up,
          },
          n = {
            ['q'] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = find_command,
          hidden = true,
        },
      },
    }
  end,
}
