-- TODO: Go through this code
local M = {}

function M.lsp_rename()
  local curr_name = vim.fn.expand '<cword>'
  local params = vim.lsp.util.make_position_params(0, 'utf-8')

  local function on_submit(new_name)
    if not new_name or #new_name == 0 or curr_name == new_name then
      -- do nothing if `new_name` is empty or not changed.
      return
    end

    -- add `newName` property to `params`.
    -- this is needed for making `textDocument/rename` request.
    ---@diagnostic disable-next-line: inject-field
    params.newName = new_name

    -- send the `textDocument/rename` request to LSP server
    vim.lsp.buf_request(0, 'textDocument/rename', params, function(_, result, _, _)
      if not result then
        -- do nothing if server returns empty result
        return
      end

      -- the `result` contains all the places we need to update the
      -- name of the identifier. so we apply those edits.
      vim.lsp.util.apply_workspace_edit(result, 'utf-8')

      -- after the edits are applied, the files are not saved automatically.
      -- let's remind ourselves to save those...
      local total_files = result.changes and vim.tbl_count(result.changes) or 0
      print(string.format("Changed %s file%s. To save them run ':wa'", total_files, total_files > 1 and 's' or ''))
    end)
  end

  local Input = require 'nui.input'

  local popup_options = {
    -- border for the window
    border = {
      style = 'rounded',
      text = {
        top = '[Rename]',
        top_align = 'left',
      },
    },
    -- highlight for the window.
    highlight = 'Normal:Normal',
    -- place the popup window relative to the
    -- buffer position of the identifier
    relative = {
      type = 'buf',
      position = {
        -- this is the same `params` we got earlier
        row = params.position.line,
        col = params.position.character,
      },
    },
    -- position the popup window on the line below identifier
    position = {
      row = 1,
      col = 0,
    },
    -- 25 cells wide, should be enough for most identifier names
    size = {
      width = 25,
      height = 1,
    },
  }

  local input = Input(popup_options, {
    -- set the default value to current name
    default_value = curr_name,
    -- pass the `on_submit` callback function we wrote earlier
    on_submit = on_submit,
    prompt = '',
  })

  -- close on <esc> in normal mode
  input:map('n', '<esc>', function() input.input_props.on_close() end, { noremap = true })

  local event = require('nui.utils.autocmd').event

  -- close when cursor leaves the buffer
  input:on(event.BufLeave, function() input.input_props.on_close() end, { once = true })

  input:mount()
end

return M
