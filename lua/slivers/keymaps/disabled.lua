local map = Slivers.keymaps.safe_keymap_set

-- Disable arrow keys in normal mode
map('n', '<left>', '<nop>')
map('n', '<down>', '<nop>')
map('n', '<up>', '<nop>')
map('n', '<right>', '<nop>')

-- Disable `s` key for flash plugin
map({ 'n', 'x' }, 's', '<nop>')

local letters = 'abcegijklmopqtuvwxyzABCDEGHIJKLMNOPQRSTUVWXYZ'

-- Disable `m` for match operations and all m<letter> combinations
for c in string.gmatch(letters, '.') do
  map({ 'n', 'x' }, 'm' .. c, '<nop>')
end

-- Hide m[a-zA-Z] combinations from which-key
Slivers.lazy.on_load('which-key.nvim', function()
  vim.schedule(function()
    local hidden_keys = {}
    for c in string.gmatch(letters, '.') do
      table.insert(hidden_keys, { 'm' .. c, hidden = true, mode = { 'n', 'x' } })
    end
    require('which-key').add(hidden_keys)
  end)
end)
