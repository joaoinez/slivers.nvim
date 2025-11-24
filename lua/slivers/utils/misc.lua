---@class utils.misc
local M = {}

--- Add syntax matching rules for highlighting URLs/URIs.
function M.set_url_effect()
  --- regex used for matching a valid URL/URI string
  local url_matcher = '\\v\\c%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)'
    .. '%([&:#*@~%_\\-=?!+;/0-9a-z]+%(%([.;/?]|[.][.]+)'
    .. '[&:#*@~%_\\-=?!+/0-9a-z]+|:\\d+|,%(%(%(h?ttps?|ftp|file|ssh|git)://|'
    .. '[a-z]+[@][a-z]+[.][a-z]+:)@![0-9a-z]+))*|\\([&:#*@~%_\\-=?!+;/.0-9a-z]*\\)'
    .. '|\\[[&:#*@~%_\\-=?!+;/.0-9a-z]*\\]|\\{%([&:#*@~%_\\-=?!+;/.0-9a-z]*'
    .. '|\\{[&:#*@~%_\\-=?!+;/.0-9a-z]*})\\})+'

  M.delete_url_effect()
  vim.fn.matchadd('HighlightURL', url_matcher, 15)
end

--- Delete the syntax matching rules for URLs/URIs if set.
function M.delete_url_effect()
  for _, match in ipairs(vim.fn.getmatches()) do
    if match.group == 'HighlightURL' then vim.fn.matchdelete(match.id) end
  end
end

function M.file_exists(file) return vim.uv.fs_stat(file) ~= nil end

function M.read_file(file)
  local fd = assert(io.open(file, 'r'))
  ---@type string
  local data = fd:read '*a'
  fd:close()
  return data
end

function M.write_file(file, contents)
  local fd = assert(io.open(file, 'w+'))
  fd:write(contents)
  fd:close()
end

function M.open_term_with_cmd(cmd)
  local autocmd = Slivers.autocmds.autocmd
  local augroup = Slivers.autocmds.augroup

  autocmd('TermOpen', {
    group = augroup 'term_cmd',
    once = true,
    callback = function()
      vim.o.number = false
      vim.o.relativenumber = false

      vim.cmd 'norm i'
    end,
  })

  local buf = vim.api.nvim_create_buf(false, true)

  vim.cmd.new()
  vim.api.nvim_win_set_buf(0, buf)
  vim.cmd.term(cmd)
  vim.cmd.wincmd 'K'
  vim.api.nvim_win_set_height(0, 15)

  vim.api.nvim_create_autocmd('TermClose', {
    group = augroup 'term_cmd',
    once = true,
    buffer = buf,
    callback = function()
      vim.api.nvim_buf_delete(buf, { force = true })
      vim.cmd 'set autoread | checktime'
    end,
  })

  vim.bo[buf].buflisted = false
end

function M.create_floating_window(opts)
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
  local buf = vim.api.nvim_create_buf(false, true)
  local win_config = vim.tbl_deep_extend('force', {
    width = width,
    height = height,
    col = col,
    row = row,
  }, opts.win)
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

function M.get_selected_code()
  local start_pos = vim.fn.getpos 'v'
  local end_pos = vim.fn.getpos '.'

  -- Get the start and end line and column numbers
  local start_line = start_pos[2]
  local start_col = start_pos[3]
  local end_line = end_pos[2]
  local end_col = end_pos[3]
  -- If the start point is after the end point, swap them
  if start_line > end_line or (start_line == end_line and start_col > end_col) then
    start_line, end_line = end_line, start_line
    start_col, end_col = end_col, start_col
  end
  local content = '' -- luacheck: ignore
  -- Check if it's a single-line selection
  if start_line == end_line then
    -- Get partial content of a single line
    local line = vim.fn.getline(start_line)
    -- content = string.sub(line, start_col, end_col)
    content = line
  else
    -- Multi-line selection: Get all lines in the selection
    local lines = vim.fn.getline(start_line, end_line)
    if vim.fn.mode() == 'v' then
      -- Extract partial content of the first line
      lines[1] = string.sub(lines[1], start_col)
      -- Extract partial content of the last line
      lines[#lines] = string.sub(lines[#lines], 1, end_col)
    end
    -- Concatenate all lines in the selection into a string
    if type(lines) == 'table' then
      content = table.concat(lines, '\n')
    else
      content = lines
    end
  end

  if not content then return nil end

  -- Add line numbers to each line
  local lines_with_numbers = {}
  local content_lines = vim.split(content, '\n', { plain = true })
  for i, line in ipairs(content_lines) do
    local line_num = start_line + i - 1
    table.insert(lines_with_numbers, string.format('%d | %s', line_num, line))
  end
  local numbered_content = table.concat(lines_with_numbers, '\n')

  -- Wrap content in code blocks
  local wrapped_content = '\n```\n' .. numbered_content .. '\n```\n\n'

  return wrapped_content
end

--- Opens a url in the default browser.
---
---@param url string
function M.open_url(url)
  local cmd
  if vim.fn.has 'mac' == 1 then
    cmd = { 'open', url }
  elseif vim.fn.has 'unix' == 1 then
    cmd = { 'xdg-open', url }
  elseif vim.fn.has 'win32' == 1 then
    cmd = { 'cmd', '/c', 'start', '', url }
  else
    print 'Unsupported OS'
    return
  end

  vim.fn.jobstart(cmd, { detach = true })
end

--- Opens current file in another code editor
---
---@param editor slivers.EditorFileCmd
function M.open_file_in_editor(editor)
  ---@enum (key) slivers.EditorFileCmd
  local editor_commands = {
    vscode = 'code -g %s:%d:%d',
    zed = 'zed %s:%d:%d',
    rider = '~/.local/bin/rider.sh %s --line %d --column %d',
  }

  local cmd_format = editor_commands[editor]
  if not cmd_format then
    vim.notify("Editor '" .. editor .. "' not configured", vim.log.levels.ERROR)
    return
  end

  local file = vim.api.nvim_buf_get_name(0)
  local line = vim.fn.line '.'
  local col = vim.fn.col '.'

  local command = string.format(cmd_format, vim.fn.shellescape(file), line, col)

  if vim.fn.has 'win32' == 1 then
    vim.fn.system('start cmd /c "' .. command .. '"')
  else
    vim.fn.system(command .. ' &')
  end
end

--- Opens current project in another code editor
---
---@param editor slivers.EditorProjectCmd
function M.open_project_in_editor(editor)
  ---@enum (key) slivers.EditorProjectCmd
  local editor_commands = {
    vscode = 'code .',
    zed = 'zed .',
    rider = '~/.local/bin/rider.sh .',
  }

  local cmd_format = editor_commands[editor]
  if not cmd_format then
    vim.notify("Editor '" .. editor .. "' not configured", vim.log.levels.ERROR)
    return
  end

  local file = vim.api.nvim_buf_get_name(0)
  local line = vim.fn.line '.'
  local col = vim.fn.col '.'

  local command = string.format(cmd_format, vim.fn.shellescape(file), line, col)

  if vim.fn.has 'win32' == 1 then
    vim.fn.system('start cmd /c "' .. command .. '"')
  else
    vim.fn.system(command .. ' &')
  end
end

return M
