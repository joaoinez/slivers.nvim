local map = Slivers.keymaps.safe_keymap_set

local state = {}
local marks_stack = {}

vim.schedule(function()
  local global_marks = vim.fn.getmarklist()

  for i = string.byte 'A', string.byte 'Z' do
    local mark = string.char(i)
    state[mark] = true

    for _, existing_mark in ipairs(global_marks) do
      local mark_name = existing_mark.mark:sub(2)

      if mark_name == mark then
        state[mark] = false
        table.insert(marks_stack, mark)
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

local function remove_from_stack(mark)
  for i, m in ipairs(marks_stack) do
    if m == mark then
      table.remove(marks_stack, i)
      return
    end
  end
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
    remove_from_stack(existing_mark)
    return
  end

  local mark = get_next_available_mark()

  if mark then
    vim.cmd('mark ' .. mark)
    state[mark] = false
    table.insert(marks_stack, mark)
  else
    vim.notify('No available global marks!', vim.log.levels.WARN)
  end
end

-- Add Mark
map('n', '<leader>m', function() add_mark() end, { desc = 'Mark' })

-- Navigate to marks by position
map('n', '<A-u>', function()
  if #marks_stack >= 1 then vim.cmd("'" .. marks_stack[1]) end
end, { desc = 'Go to most recent mark' })

map('n', '<A-i>', function()
  if #marks_stack >= 2 then vim.cmd("'" .. marks_stack[2]) end
end, { desc = 'Go to second most recent mark' })

map('n', '<A-o>', function()
  if #marks_stack >= 3 then vim.cmd("'" .. marks_stack[3]) end
end, { desc = 'Go to third most recent mark' })

map('n', '<A-p>', function()
  if #marks_stack >= 3 then vim.cmd("'" .. marks_stack[4]) end
end, { desc = 'Go to fourth most recent mark' })

-- Clear marks
map('n', '<leader>km', function()
  vim.cmd 'delm A-Z'
  marks_stack = {}
  for mark, _ in pairs(state) do
    state[mark] = true
  end
end, { desc = 'Clear Marks' })
