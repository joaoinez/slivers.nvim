local map = Slivers.keymaps.safe_keymap_set

-- Disable arrow keys in normal mode
map('n', '<left>', '<nop>')
map('n', '<down>', '<nop>')
map('n', '<up>', '<nop>')
map('n', '<right>', '<nop>')

-- Disable `s` key for flash and surround plugins
map('n', 's', '<nop>')
map('x', 's', '<nop>')
