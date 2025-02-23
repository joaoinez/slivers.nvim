-- TODO: Look through this code

local map = Slivers.keymaps.safe_keymap_set

-- Track marks with boolean flags
local marks_state = {
  global = {},
  ['local'] = {},
}

-- Initialize marks state and check existing marks
-- Get existing marks
local global_marks = vim.fn.getmarklist()
local local_marks = vim.fn.getmarklist(vim.api.nvim_get_current_buf())

-- Initialize global marks (A-Z)
for i = string.byte 'A', string.byte 'Z' do
  local mark = string.char(i)
  marks_state.global[mark] = true -- Default to available

  -- Check if mark exists in global marks
  for _, existing_mark in ipairs(global_marks) do
    local mark_name = existing_mark.mark:sub(2)
    if mark_name == mark then
      marks_state.global[mark] = false -- Mark as used
      break
    end
  end
end

-- Initialize local marks (a-z)
for i = string.byte 'a', string.byte 'z' do
  local mark = string.char(i)
  marks_state['local'][mark] = true -- Default to available

  -- Check if mark exists in local marks
  for _, existing_mark in ipairs(local_marks) do
    local mark_name = existing_mark.mark:sub(2)
    if mark_name == mark then
      marks_state['local'][mark] = false -- Mark as used
      break
    end
  end
end

-- Get the first available mark
local function get_next_available_mark(is_local)
  local state_table = is_local and marks_state['local'] or marks_state.global
  for mark, available in pairs(state_table) do
    if available then return mark end
  end
  return nil -- All marks are used
end

-- Function to get mark at current line
local function get_mark_at_current_line(is_local)
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local mark_list = is_local and vim.fn.getmarklist(vim.api.nvim_get_current_buf()) or vim.fn.getmarklist()
  local mark_pattern = is_local and '^[a-z]$' or '^[A-Z]$'

  for _, mark in ipairs(mark_list) do
    local mark_name = mark.mark:sub(2) -- Remove the ' prefix
    if mark_name:match(mark_pattern) then
      local mark_pos = vim.api.nvim_buf_get_mark(0, mark.mark:sub(2))
      if mark_pos[1] == current_line then return mark_name end
    end
  end
  return nil
end

-- Function to add the next available mark
local function add_mark(is_local)
  local state_table = is_local and marks_state['local'] or marks_state.global
  local mark_type = is_local and 'local' or 'global'

  -- Check if there's already a mark on this line
  local existing_mark = get_mark_at_current_line(is_local)
  if existing_mark then
    vim.cmd('delm ' .. existing_mark)
    state_table[existing_mark] = true -- Mark as available
    vim.notify(string.format("Removed %s mark '%s'", mark_type, existing_mark), vim.log.levels.INFO)
    return
  end

  local mark = get_next_available_mark(is_local)
  if mark then
    vim.cmd('mark ' .. mark)
    state_table[mark] = false -- Mark as used
    vim.notify(string.format("Added %s mark '%s'", mark_type, mark), vim.log.levels.INFO)
  else
    vim.notify(string.format('No available %s marks!', mark_type), vim.log.levels.WARN)
  end
end

-- Add next available mark (global and local)
map('n', '<leader>ml', function() add_mark(true) end, { desc = 'Add (local)' })
map('n', '<leader>ma', function() add_mark(false) end, { desc = 'Add (global)' })

-- Clear marks
map('n', '<leader>mc', '<cmd>delm a-z<cr>', { desc = 'Clear Marks (local)' })
map('n', '<leader>mC', '<cmd>delm A-Z<cr>', { desc = 'Clear Marks (global)' })
