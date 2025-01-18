---@type LazySpec
return {
  'echasnovski/mini.files',
  enabled = true,
  version = false,
  keys = {
    {
      '<leader>fe',
      function() require('mini.files').open(vim.api.nvim_buf_get_name(0), true) end,
      desc = 'File Explorer (mini)',
    },
  },
  opts = {
    mappings = {
      synchronize = 's',
    },
  },
  config = function(_, opts)
    require('mini.files').setup(opts)

    local show_dotfiles = true

    ---@diagnostic disable-next-line: unused-local
    local filter_show = function(fs_entry) return true end

    local filter_hide = function(fs_entry) return not vim.startswith(fs_entry.name, '.') end

    local toggle_dotfiles = function()
      show_dotfiles = not show_dotfiles
      local new_filter = show_dotfiles and filter_show or filter_hide
      MiniFiles.refresh { content = { filter = new_filter } }
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id

        vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
        vim.keymap.set(
          'n',
          '<cr>',
          function() require('mini.files').go_in { close_on_file = true } end,
          { buffer = buf_id }
        )
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesActionRename',
      callback = function(event) require('snacks').rename.on_rename_file(event.data.from, event.data.to) end,
    })
  end,
}
