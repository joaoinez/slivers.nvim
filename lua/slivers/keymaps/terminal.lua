local map = Slivers.keymaps.safe_keymap_set

map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Toggle terminal
map('t', '<C-/>', '<cmd>close<cr>', { desc = 'Hide Terminal' })
map('t', '<C-_>', '<cmd>close<cr>', { desc = 'which_key_ignore' })

-- Move windows in terminal mode
map('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Move focus to the left window' })
map('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = 'Move focus to the lower window' })
map('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = 'Move focus to the upper window' })
map('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = 'Move focus to the right window' })

-- REPL node
map('n', '<leader>krn', function() Slivers.misc.open_term_with_cmd 'node' end, { desc = 'Node' })

-- REPL lua
map('n', '<leader>krl', function() Slivers.misc.open_term_with_cmd 'lua' end, { desc = 'Lua' })

-- REPL python
map('n', '<leader>krp', function() Slivers.misc.open_term_with_cmd 'python3' end, { desc = 'Python' })

-- Toggle aider
map('n', '<leader>ai', function()
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

  vim.cmd.vnew()
  vim.api.nvim_win_set_buf(0, buf)
  vim.cmd.term 'aider --watch-files --architect'
  vim.cmd.wincmd 'L'
  vim.api.nvim_win_set_width(0, math.floor(vim.o.columns * 0.30))

  vim.api.nvim_create_autocmd('TermClose', {
    group = augroup 'term_cmd',
    once = true,
    buffer = buf,
    callback = function()
      vim.api.nvim_buf_delete(buf, { force = true })
      vim.cmd.checktime()
    end,
  })

  vim.bo[buf].buflisted = false
end, { desc = 'Aider' })
