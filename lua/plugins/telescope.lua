return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function() return vim.fn.executable 'make' == 1 end,
    },
  },
  keys = {
    { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Find Files (Root Dir)' },
    { '<leader>ft', function() require('telescope.builtin').live_grep() end, desc = 'Find Text (Grep)' },
    { '<leader><leader>', function() require('telescope.builtin').buffers() end, desc = 'Open Buffers' },
    { '<leader>f?', function() require('telescope.builtin').keymaps() end, desc = 'Buffer Keymaps (telescope)' },
  },
  config = function()
    local telescope = require 'telescope'
    local builtin = require 'telescope.builtin'
    local actions = require 'telescope.actions'

    local open_with_trouble = function(...) require('trouble.sources.telescope').open(...) end

    local find_files_no_ignore = function()
      local action_state = require 'telescope.actions.state'
      local line = action_state.get_current_line()
      builtin.find_files { no_ignore = true, default_text = line }
    end

    local find_files_with_hidden = function()
      local action_state = require 'telescope.actions.state'
      local line = action_state.get_current_line()
      builtin.find_files { hidden = true, default_text = line }
    end

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

    telescope.setup {
      defaults = {
        prompt_prefix = ' ',
        selection_caret = ' ',
        mappings = {
          i = {
            ['<C-q>'] = open_with_trouble,
            ['<A-q>'] = open_with_trouble,
            ['<A-i>'] = find_files_no_ignore,
            ['<A-h>'] = find_files_with_hidden,
            ['<C-f>'] = actions.preview_scrolling_down,
            ['<C-b>'] = actions.preview_scrolling_up,
          },
          n = {
            ['<C-q>'] = open_with_trouble,
            ['<A-q>'] = open_with_trouble,
            ['q'] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = find_command,
          hidden = true,
        },
        live_grep = {
          theme = 'dropdown',
        },
        keymaps = {
          theme = 'ivy',
        },
        lsp_definitions = {
          theme = 'dropdown',
        },
        lsp_references = {
          theme = 'dropdown',
        },
        lsp_implementations = {
          theme = 'dropdown',
        },
        lsp_type_definitions = {
          theme = 'dropdown',
        },
        lsp_document_symbols = {
          theme = 'dropdown',
        },
        lsp_dynamic_workspace_symbols = {
          theme = 'dropdown',
        },
      },
    }

    pcall(telescope.load_extension, 'fzf')
  end,
}
