local map = Slivers.keymaps.safe_keymap_set

local state = {}

vim.schedule(function()
  local global_marks = vim.fn.getmarklist()

  for i = string.byte 'A', string.byte 'Z' do
    local mark = string.char(i)
    state[mark] = true

    for _, existing_mark in ipairs(global_marks) do
      local mark_name = existing_mark.mark:sub(2)

      if mark_name == mark then
        state[mark] = false

        break
      end
    end
  end
end)

local function get_mark_at_current_line()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]

  for _, mark in ipairs(vim.fn.getmarklist()) do
    local mark_name = mark.mark:sub(2)

    if mark_name:match '^[A-Z]$' then
      local mark_pos = vim.api.nvim_buf_get_mark(0, mark.mark:sub(2))

      if mark_pos[1] == current_line then return mark_name end
    end
  end

  return nil
end

local function get_next_available_mark()
  for mark, available in pairs(state) do
    if available then return mark end
  end

  return nil
end

local function add_mark()
  local existing_mark = get_mark_at_current_line()

  if existing_mark then
    vim.cmd('delm ' .. existing_mark)
    state[existing_mark] = true

    return
  end

  local mark = get_next_available_mark()

  if mark then
    vim.cmd('mark ' .. mark)
    state[mark] = false
  else
    vim.notify('No available global marks!', vim.log.levels.WARN)
  end
end

-- Add Mark
map('n', '<leader>m', function() add_mark() end, { desc = 'Mark' })

-- Clear marks
map('n', '<leader>km', '<cmd>delm A-Z<cr>', { desc = 'Clear Marks' })
