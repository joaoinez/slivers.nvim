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

-- Open opencode
map({ 'n', 'v' }, '<leader>aoc', function()
  local in_tmux = vim.fn.exists '$TMUX' == 1
  if not in_tmux then
    vim.notify('Not running inside tmux', vim.log.levels.WARN)
    return
  end

  if not is_pane_open() then
    pane_id = vim.fn.system "tmux split-window -P -F '#{pane_id}' -h -p 40 'opencode'"

    vim.defer_fn(function()
      vim.fn.system(
        string.format(
          'tmux send-keys -t %s -l %s',
          vim.fn.trim(pane_id),
          vim.fn.shellescape('@' .. vim.fn.expand '%:.')
        )
      )

      vim.fn.system('tmux select-pane -t ' .. pane_id)
      vim.fn.system 'tmux send-keys Space'

      if vim.fn.mode() == 'v' or vim.fn.mode() == 'V' then
        local selected_code = Slivers.misc.get_selected_code()

        if selected_code then
          vim.fn.system(
            string.format('tmux send-keys -t %s -l %s', vim.fn.trim(pane_id), vim.fn.shellescape(selected_code))
          )
        end
      end
    end, 1200)
  else
    vim.fn.system('tmux select-pane -t ' .. pane_id)
  end
end, { desc = 'Opencode' })

-- Open opencode where you left off
map({ 'n', 'v' }, '<leader>aor', function()
  local in_tmux = vim.fn.exists '$TMUX' == 1
  if not in_tmux then
    vim.notify('Not running inside tmux', vim.log.levels.WARN)
    return
  end
  local panes = (vim.fn.system 'tmux list-panes -F "#{pane_id}"'):gsub('\n', ' '):gsub('%%', '')
  if not pane_id or panes:find((vim.fn.trim(pane_id):gsub('%%', ''))) == nil then
    pane_id = vim.fn.system 'tmux split-window -P -F "#{pane_id}" -h -p 40 "opencode -c"'

    vim.defer_fn(function()
      vim.fn.system(
        string.format(
          'tmux send-keys -t %s -l %s',
          vim.fn.trim(pane_id),
          vim.fn.shellescape('@' .. vim.fn.expand '%:.')
        )
      )

      vim.fn.system('tmux select-pane -t ' .. pane_id)
      vim.fn.system 'tmux send-keys Space'

      if vim.fn.mode() == 'v' or vim.fn.mode() == 'V' then
        local selected_code = Slivers.misc.get_selected_code()

        if selected_code then
          vim.fn.system(
            string.format('tmux send-keys -t %s -l %s', vim.fn.trim(pane_id), vim.fn.shellescape(selected_code))
          )
        end
      end
    end, 1200)
  else
    vim.fn.system('tmux select-pane -t ' .. pane_id)
  end
end, { desc = 'Resume Previous Chat' })

-- Add current file as context
map('n', '<leader>aof', function()
  local in_tmux = vim.fn.exists '$TMUX' == 1
  if not in_tmux then
    vim.notify('Not running inside tmux', vim.log.levels.WARN)
    return
  end
  local panes = (vim.fn.system 'tmux list-panes -F "#{pane_id}"'):gsub('\n', ' '):gsub('%%', '')
  if not pane_id or panes:find((vim.fn.trim(pane_id):gsub('%%', ''))) == nil then
    vim.notify('No Opencode pane open', vim.log.levels.WARN)
    return
  end

  vim.fn.system(
    string.format('tmux send-keys -t %s -l %s', vim.fn.trim(pane_id), vim.fn.shellescape('@' .. vim.fn.expand '%:.'))
  )
  vim.fn.system('tmux select-pane -t ' .. pane_id)
  vim.fn.system 'tmux send-keys Space'
end, { desc = 'Add File to Context' })

-- Add selection as context
map('v', '<leader>aos', function()
  local in_tmux = vim.fn.exists '$TMUX' == 1
  if not in_tmux then
    vim.notify('Not running inside tmux', vim.log.levels.WARN)
    return
  end
  if not is_pane_open() then
    vim.notify('No Opencode pane open', vim.log.levels.WARN)
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

-- Create a commit
map('n', '<leader>gC', function()
  local in_tmux = vim.fn.exists '$TMUX' == 1
  if not in_tmux then
    vim.notify('Not running inside tmux', vim.log.levels.WARN)
    return
  end

  if not pane_id or not is_pane_open() then
    pane_id =
      vim.fn.system [[tmux split-window -P -F "#{pane_id}" -h -p 40 "opencode -p 'Create a commit. When writing the commit use the conventional commits convention.'"]]
  end
end, { desc = 'Commit (opencode)' })

-- Create a PR
map('n', '<leader>gO', function()
  local in_tmux = vim.fn.exists '$TMUX' == 1
  if not in_tmux then
    vim.notify('Not running inside tmux', vim.log.levels.WARN)
    return
  end

  local message = 'Create a pr. All changes have already been committed and pushed to origin.'

  if not pane_id or not is_pane_open() then
    pane_id =
      vim.fn.system(string.format([[tmux split-window -P -F "#{pane_id}" -h -p 40 "opencode -p '%s'"]], message))
  else
    vim.fn.system('tmux select-pane -t ' .. pane_id)
    vim.fn.system(string.format('tmux send-keys -t %s -l %s', vim.fn.trim(pane_id), vim.fn.shellescape(message)))
    vim.fn.system 'tmux send-keys Enter'
  end
end, { desc = 'Create PR (opencode)' })

-- Toggle Opencode
map('n', '<leader>to', function()
  local in_tmux = vim.fn.exists '$TMUX' == 1
  if not in_tmux then
    vim.notify('Not running inside tmux', vim.log.levels.WARN)
    return
  end
  if not is_pane_open() then
    vim.notify('No Opencode pane open', vim.log.levels.WARN)
    return
  end

  if is_pane_zoomed() then
    vim.fn.system('tmux select-pane -t ' .. pane_id)
  else
    vim.fn.system 'tmux resize-pane -Z'
  end
end, { desc = 'Toggle Opencode' })
