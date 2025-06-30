local map = Slivers.keymaps.safe_keymap_set

---@type string | nil
local pane_id = nil

local function is_pane_open()
  if not pane_id then return false end

  local panes = (vim.fn.system 'tmux list-panes -F "#{pane_id}"'):gsub('\n', ' '):gsub('%%', '')

  return panes:find((vim.fn.trim(pane_id):gsub('%%', ''))) ~= nil
end

local function is_pane_zoomed()
  local is_zoomed_str = vim.fn.system("tmux display-message -p '#{window_zoomed_flag}'"):gsub('%s+', '')

  return tonumber(is_zoomed_str) == 1
end

-- Open Gemini CLI
map({ 'n', 'v' }, '<leader>agg', function()
  local in_tmux = vim.fn.exists '$TMUX' == 1
  if not in_tmux then
    vim.notify('Not running inside tmux', vim.log.levels.WARN)
    return
  end

  if not is_pane_open() then
    pane_id = vim.fn.system "tmux split-window -P -F '#{pane_id}' -h -p 40 'gemini'"
  else
    vim.fn.system('tmux select-pane -t ' .. pane_id)
  end
end, { desc = 'Gemini CLI' })

-- Add current file as context
map('n', '<leader>agf', function()
  local in_tmux = vim.fn.exists '$TMUX' == 1
  if not in_tmux then
    vim.notify('Not running inside tmux', vim.log.levels.WARN)
    return
  end
  local panes = (vim.fn.system 'tmux list-panes -F "#{pane_id}"'):gsub('\n', ' '):gsub('%%', '')
  if not pane_id or panes:find((vim.fn.trim(pane_id):gsub('%%', ''))) == nil then
    vim.notify('No Gemini CLI pane open', vim.log.levels.WARN)
    return
  end

  vim.fn.system(
    string.format('tmux send-keys -t %s -l %s', vim.fn.trim(pane_id), vim.fn.shellescape('@' .. vim.fn.expand '%:.'))
  )
  vim.fn.system('tmux select-pane -t ' .. pane_id)
  vim.fn.system 'tmux send-keys Space'
end, { desc = 'Add File to Context' })

-- Add selection as context
map('v', '<leader>ags', function()
  local in_tmux = vim.fn.exists '$TMUX' == 1
  if not in_tmux then
    vim.notify('Not running inside tmux', vim.log.levels.WARN)
    return
  end
  if not is_pane_open() then
    vim.notify('No Gemini CLI pane open', vim.log.levels.WARN)
    return
  end

  local selected_code = Slivers.misc.get_selected_code()

  if selected_code then
    vim.fn.system(
      string.format('tmux send-keys -t %s -l %s', vim.fn.trim(pane_id or '0'), vim.fn.shellescape(selected_code))
    )
  end
  vim.fn.system('tmux select-pane -t ' .. pane_id)
end, { desc = 'Add Selection to Context' })

-- Toggle Gemini CLI
map('n', '<leader>tg', function()
  local in_tmux = vim.fn.exists '$TMUX' == 1
  if not in_tmux then
    vim.notify('Not running inside tmux', vim.log.levels.WARN)
    return
  end
  if not is_pane_open() then
    vim.notify('No Gemini CLI pane open', vim.log.levels.WARN)
    return
  end

  if is_pane_zoomed() then
    vim.fn.system('tmux select-pane -t ' .. pane_id)
  else
    vim.fn.system 'tmux resize-pane -Z'
  end
end, { desc = 'Toggle Gemini CLI' })
