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
  vim.cmd.new()

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, buf)

  vim.cmd.term(cmd)
  vim.cmd.wincmd 'J'
  vim.api.nvim_win_set_height(0, 15)

  vim.api.nvim_create_autocmd('TermClose', {
    once = true,
    buffer = buf,
    callback = function()
      vim.api.nvim_buf_delete(buf, { force = true })
      vim.cmd.checktime()
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
  local win_config = vim.tbl_deep_extend('force', opts.win, {
    width = width,
    height = height,
    col = col,
    row = row,
  })
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

return M
