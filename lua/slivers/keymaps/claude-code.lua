local map = Slivers.keymaps.safe_keymap_set

---@type string | nil
local pane_id = nil

if vim.g.ai_chat == 'claude-code' then
  -- Open Claude Code
  map({ 'n', 'v' }, '<leader>aa', function()
    local in_tmux = vim.fn.exists '$TMUX' == 1
    if not in_tmux then
      vim.notify('Not running inside tmux', vim.log.levels.WARN)
      return
    end

    local socket_path = vim.v.servername or vim.g.nvim_socket_path

    if not pane_id then
      pane_id = vim.fn.system(
        string.format(
          [[tmux split-window -P -F "#{pane_id}" -h -p 40 "claude --append-system-prompt 'You have access to a Neovim instance on socket %s. Use nvim --server %s --remote-send <cmd> for commands, --remote-expr <expr> for expressions, --remote-tab <file> for opening files. Integrate seamlessly for pair programming.'"]],
          socket_path,
          socket_path
        )
      )

      vim.defer_fn(function()
        vim.fn.system(
          string.format(
            'tmux send-keys -t %s -l %s',
            vim.fn.trim(pane_id),
            vim.fn.shellescape '@' .. vim.fn.expand '%:.'
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
      end, 750)
    else
      vim.fn.system('tmux select-pane -t ' .. pane_id)
    end
  end, { desc = 'Claude Code' })

  -- Open Claude Code where you left off
  map({ 'n', 'v' }, '<leader>ac', function()
    local in_tmux = vim.fn.exists '$TMUX' == 1
    if not in_tmux then
      vim.notify('Not running inside tmux', vim.log.levels.WARN)
      return
    end

    if not pane_id then
      pane_id = vim.fn.system 'tmux split-window -P -F "#{pane_id}" -h -p 40 "claude -c"'

      vim.defer_fn(function()
        vim.fn.system(
          string.format(
            'tmux send-keys -t %s -l %s',
            vim.fn.trim(pane_id),
            vim.fn.shellescape '@' .. vim.fn.expand '%:.'
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
      end, 750)
    else
      vim.fn.system('tmux select-pane -t ' .. pane_id)
    end
  end, { desc = 'Continue Previous Chat' })

  -- Open Claude Code where you left off
  map('n', '<leader>ar', function()
    local in_tmux = vim.fn.exists '$TMUX' == 1
    if not in_tmux then
      vim.notify('Not running inside tmux', vim.log.levels.WARN)
      return
    end

    if not pane_id then
      pane_id = vim.fn.system 'tmux split-window -P -F "#{pane_id}" -h -p 40 "claude -r"'
    else
      vim.fn.system('tmux select-pane -t ' .. pane_id)
    end
  end, { desc = 'Resume Past Chat' })

  -- Add current file as context
  map('n', '<leader>af', function()
    local in_tmux = vim.fn.exists '$TMUX' == 1
    if not in_tmux then
      vim.notify('Not running inside tmux', vim.log.levels.WARN)
      return
    end
    if not pane_id then
      vim.notify('No Claude Code pane open', vim.log.levels.WARN)
      return
    end

    vim.fn.system(
      string.format('tmux send-keys -t %s -l %s', vim.fn.trim(pane_id), vim.fn.shellescape '@' .. vim.fn.expand '%:.')
    )
    vim.fn.system('tmux select-pane -t ' .. pane_id)
    vim.fn.system 'tmux send-keys Space'
  end, { desc = 'Add current file to context' })

  -- Add selection as context
  map('v', '<leader>as', function()
    local in_tmux = vim.fn.exists '$TMUX' == 1
    if not in_tmux then
      vim.notify('Not running inside tmux', vim.log.levels.WARN)
      return
    end
    if not pane_id then
      vim.notify('No Claude Code pane open', vim.log.levels.WARN)
      return
    end

    local selected_code = Slivers.misc.get_selected_code()

    if selected_code then
      vim.fn.system(
        string.format('tmux send-keys -t %s -l %s', vim.fn.trim(pane_id), vim.fn.shellescape(selected_code))
      )
    end
    vim.fn.system('tmux select-pane -t ' .. pane_id)
  end, { desc = 'Send selection with code blocks' })
else
  -- Open Claude Code
  map('n', '<leader>ac', function()
    local in_tmux = vim.fn.exists '$TMUX' == 1
    if not in_tmux then
      vim.notify('Not running inside tmux', vim.log.levels.WARN)
      return
    end

    vim.fn.system 'tmux split-window -h -p 40 "claude"'
  end, { desc = 'Claude Code' })
end
