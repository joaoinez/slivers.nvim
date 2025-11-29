local M = {}

function M.create_scaffold(folder_name, files)
  local buf_id = vim.api.nvim_get_current_buf()

  -- Get current cursor position to insert after
  local row = vim.api.nvim_win_get_cursor(0)[1]

  local scaffold_items = {
    folder_name .. '/',
  }

  for name, _ in pairs(files) do
    table.insert(scaffold_items, folder_name .. '/' .. name)
  end

  -- Insert the lines into the buffer
  vim.api.nvim_buf_set_lines(buf_id, row, row, false, scaffold_items)

  -- Synchronize to create the files and populate with content
  vim.defer_fn(function()
    MiniFiles.synchronize()

    -- After synchronization, populate files with content
    vim.defer_fn(function()
      local entry = MiniFiles.get_fs_entry(buf_id, row + 1)
      if entry then
        local base_path = vim.fs.dirname(entry.path)

        for name, content in pairs(files) do
          local file_path = base_path .. '/' .. folder_name .. '/' .. name
          vim.fn.writefile(vim.split(content, '\n', { plain = true }), file_path)
        end

        -- Refresh mini.files to show updated content
        MiniFiles.refresh()
      end
    end, 500)
  end, 100)
end

return M
