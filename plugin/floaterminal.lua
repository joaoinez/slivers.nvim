local state = {}

local function create_floating_window(key, opts)
  opts = vim.tbl_deep_extend('force', {
    width = math.floor(vim.o.columns * 0.9),
    height = math.floor(vim.o.lines * 0.9),
    win = {
      relative = 'editor',
      style = 'minimal',
      border = 'rounded',
      title = 'Floaterminal',
    },
  }, opts or {})

  local width = opts.width
  local height = opts.height
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf = nil
  if state[key] and vim.api.nvim_buf_is_valid(state[key].buf) then
    buf = state[key].buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end
  local win_config = vim.tbl_deep_extend('force', opts.win, {
    width = width,
    height = height,
    col = col,
    row = row,
  })
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local function toggle_floating_window(key, opts, callback)
  if not (state[key] and vim.api.nvim_win_is_valid(state[key].win)) then
    state[key] = create_floating_window(key, opts)
    if vim.bo[state[key].buf].buftype ~= 'terminal' then
      vim.cmd.term()
      if callback then callback() end
    end
  else
    vim.api.nvim_win_hide(state[key].win)
  end
end

vim.api.nvim_create_user_command('Floaterminal', function(command)
  local arg = unpack(command.fargs) -- nil|string|table
  if arg == nil then
    toggle_floating_window 'floating'
  else
    arg = type(arg) == 'table' and arg[1] or arg
    if arg == 'ollama' then
      toggle_floating_window('ollama', { win = { title = 'Ollama', border = 'none' } }, function()
        vim.fn.chansend(vim.bo[state.ollama.buf].channel, { 'clear\r\n' })
        vim.fn.chansend(vim.bo[state.ollama.buf].channel, { 'oterm\r\n' })
        -- TODO: Add keymap to close
      end)
    end
  end
end, {
  nargs = '*',
  complete = function(_, line)
    local l = vim.split(line, '%s+')
    local n = #l - 2

    if n == 0 then
      local commands = { 'ollama' }
      commands = vim.iter(commands):flatten():totable()
      table.sort(commands)
      return vim.tbl_filter(function(val) return vim.startswith(val, l[2]) end, commands)
    end
  end,
})
