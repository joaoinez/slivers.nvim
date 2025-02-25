local map = Slivers.keymaps.safe_keymap_set

-- [[ Code Edtors ]]

-- Open file in vscode
map('n', '<leader>ofc', function() Slivers.misc.open_file_in_editor 'vscode' end, { desc = 'Code' })

-- Open file in trae
map('n', '<leader>oft', function() Slivers.misc.open_file_in_editor 'trae' end, { desc = 'Trae' })

-- Open file in zed
map('n', '<leader>ofz', function() Slivers.misc.open_file_in_editor 'zed' end, { desc = 'Zed' })

-- [[ Documentation ]]

-- Conventional Commits
map(
  'n',
  '<leader>odg',
  function() Slivers.misc.open_url 'https://www.conventionalcommits.org' end,
  { desc = 'Conventional Commits' }
)

-- Expo
map('n', '<leader>ode', function() Slivers.misc.open_url 'https://docs.expo.dev' end, { desc = 'Expo' })

-- LuaCATS annotations
map(
  'n',
  '<leader>odl',
  function() Slivers.misc.open_url 'https://luals.github.io/wiki/annotations' end,
  { desc = 'Lua Types' }
)

-- [[ Web Links ]]

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
map('n', '<leader>ol', function() Slivers.misc.open_url 'https://www.lazyvim.org' end, { desc = 'LazyVim' })

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
map('n', '<leader>oe', function() Slivers.misc.open_url 'https://excalidraw.com' end, { desc = 'Excalidraw' })

-- Aider Leaderboards
map(
  'n',
  '<leader>oa',
  function() Slivers.misc.open_url 'https://aider.chat/docs/leaderboards/' end,
  { desc = 'Aider Leaderboards' }
)

-- Wakatime
map('n', '<leader>ow', function() Slivers.misc.open_url 'https://wakatime.com/dashboard' end, { desc = 'Wakatime' })
