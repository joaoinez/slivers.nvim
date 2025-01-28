local map = Slivers.keymaps.safe_keymap_set

-- Open file in vscode
map('n', '<leader>ofc', function() Slivers.misc.open_file_in_editor 'vscode' end, { desc = 'Code' })

-- Open file in trae
map('n', '<leader>oft', function() Slivers.misc.open_file_in_editor 'trae' end, { desc = 'Trae' })

-- Open file in zed
map('n', '<leader>ofz', function() Slivers.misc.open_file_in_editor 'zed' end, { desc = 'Zed' })

-- LuaCATS annotations
map(
  'n',
  '<leader>odl',
  function() Slivers.misc.open_url 'https://luals.github.io/wiki/annotations' end,
  { desc = 'Lua Types' }
)

-- https://joaoinez.me
map('n', '<leader>oj', function() Slivers.misc.open_url 'https://joaoinez.me' end, { desc = 'joaoinez.me' })

-- Deepseek R1
map(
  'n',
  '<leader>oc',
  function() Slivers.misc.open_url 'https://chat.deepseek.com/a/chat' end,
  { desc = 'AI Chat (deepseek-r1)' }
)

-- LazyVim
map('n', '<leader>ol', function() Slivers.misc.open_url 'https://www.lazyvim.org/' end, { desc = 'LazyVim' })

-- Nerdfonts Cheatsheet
map(
  'n',
  '<leader>on',
  function() Slivers.misc.open_url 'https://www.nerdfonts.com/cheat-sheet' end,
  { desc = 'Nerdfonts' }
)

-- Vim Colorschemes
map(
  'n',
  '<leader>ov',
  function() Slivers.misc.open_url 'https://vimcolorschemes.com/i/trending/b.dark/e.neovim' end,
  { desc = 'Vim Colorschemes' }
)

-- Excalidraw
map('n', '<leader>oe', function() Slivers.misc.open_url 'https://excalidraw.com/' end, { desc = 'Excalidraw' })

-- Aider Leaderboards
map(
  'n',
  '<leader>oa',
  function() Slivers.misc.open_url 'https://aider.chat/2024/12/21/polyglot.html' end,
  { desc = 'Aider Leaderboards' }
)
