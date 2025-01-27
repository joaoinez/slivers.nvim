local map = Slivers.keymaps.safe_keymap_set

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
