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

-- Next.js
map('n', '<leader>odn', function() Slivers.misc.open_url 'https://nextjs.org/docs' end, { desc = 'Next.js' })

-- TanStack Query
map(
  'n',
  '<leader>odq',
  function() Slivers.misc.open_url 'https://tanstack.com/query/latest/docs/framework/react/overview' end,
  { desc = 'TanStack Query' }
)

-- LuciaAuth
map('n', '<leader>odL', function() Slivers.misc.open_url 'https://lucia-auth.com' end, { desc = 'LuciaAuth' })

-- LuaCATS annotations
map(
  'n',
  '<leader>odl',
  function() Slivers.misc.open_url 'https://luals.github.io/wiki/annotations' end,
  { desc = 'Lua Types' }
)

-- [[ UI ]]
-- Shadcn UI
map('n', '<leader>odus', function() Slivers.misc.open_url 'https://ui.shadcn.com/docs' end, { desc = 'Shadcn UI' })

-- Origin UI
map('n', '<leader>oduo', function() Slivers.misc.open_url 'https://originui.com/' end, { desc = 'Origin UI' })

-- Tailwind UI
map(
  'n',
  '<leader>odut',
  function() Slivers.misc.open_url 'https://tailwindui.com/components' end,
  { desc = 'Tailwind UI' }
)

-- Daisy UI
map('n', '<leader>odud', function() Slivers.misc.open_url 'https://daisyui.com/docs/intro' end, { desc = 'Daisy UI' })

-- Dot UI
map(
  'n',
  '<leader>oduD',
  function() Slivers.misc.open_url 'https://next.dotui.org/docs/getting-started/introduction' end,
  { desc = 'Dot UI' }
)

-- Hero UI
map(
  'n',
  '<leader>oduh',
  function() Slivers.misc.open_url 'https://www.heroui.com/docs/guide/introduction' end,
  { desc = 'Hero UI' }
)

-- Indie UI
map(
  'n',
  '<leader>odui',
  function() Slivers.misc.open_url 'https://ui.indie-starter.dev/docs' end,
  { desc = 'Indie UI' }
)

-- Inspira UI
map(
  'n',
  '<leader>oduI',
  function() Slivers.misc.open_url 'https://inspira-ui.com/components' end,
  { desc = 'Inspira UI' }
)

-- Gluestack UI
map(
  'n',
  '<leader>oduI',
  function() Slivers.misc.open_url 'https://gluestack.io/ui/docs/components/all-components' end,
  { desc = 'Gluestack UI' }
)

-- 21st.dev
map(
  'n',
  '<leader>odu2',
  function() Slivers.misc.open_url 'https://21st.dev/?tab=components&sort=recommended' end,
  { desc = '21st.dev' }
)

-- Aceternity UI
map(
  'n',
  '<leader>odua',
  function() Slivers.misc.open_url 'https://ui.aceternity.com/components' end,
  { desc = 'Aceternity UI' }
)

-- Motion Primitives
map(
  'n',
  '<leader>oduM',
  function() Slivers.misc.open_url 'https://motion-primitives.com/docs' end,
  { desc = 'Motion Primitives' }
)

-- Magic UI
map('n', '<leader>odum', function() Slivers.misc.open_url 'https://magicui.design/docs' end, { desc = 'Magic UI' })

-- Flowbite
map('n', '<leader>oduf', function() Slivers.misc.open_url 'https://flowbite.com/blocks' end, { desc = 'Flowbite' })

-- Shadcn Blocks
map(
  'n',
  '<leader>oduS',
  function() Slivers.misc.open_url 'https://www.shadcnblocks.com/blocks' end,
  { desc = 'Shadcn Blocks' }
)

-- Tailkits
map('n', '<leader>oduT', function() Slivers.misc.open_url 'https://tailkits.com/components' end, { desc = 'Tailkits' })

-- [[ Web Links ]]
-- https://joaoinez.me
map('n', '<leader>oj', function() Slivers.misc.open_url 'https://joaoinez.me' end, { desc = 'joaoinez.me' })

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

-- Wakatime
map('n', '<leader>ow', function() Slivers.misc.open_url 'https://wakatime.com/dashboard' end, { desc = 'Wakatime' })

-- Advent of Code
map('n', '<leader>oA', function() Slivers.misc.open_url 'https://adventofcode.com' end, { desc = 'Advent of Code' })

-- Lucide Icons
map('n', '<leader>oi', function() Slivers.misc.open_url 'https://lucide.dev/icons' end, { desc = 'Lucide Icons' })

-- Fontshare
map('n', '<leader>of', function() Slivers.misc.open_url 'https://www.fontshare.com' end, { desc = 'Fontshare' })

-- [[ AI ]]
-- Aider Leaderboards
map(
  'n',
  '<leader>oal',
  function() Slivers.misc.open_url 'https://aider.chat/docs/leaderboards/' end,
  { desc = 'Aider Leaderboards' }
)

-- Anthropic Console
map(
  'n',
  '<leader>oaa',
  function() Slivers.misc.open_url 'https://console.anthropic.com/settings/billing' end,
  { desc = 'Anthropic Console' }
)

-- OpenRouter
map('n', '<leader>oao', function() Slivers.misc.open_url 'https://openrouter.ai/credits' end, { desc = 'OpenRouter' })

-- Groq
map('n', '<leader>oag', function() Slivers.misc.open_url 'https://console.groq.com/playground' end, { desc = 'Groq' })

-- Copilot
map('n', '<leader>oac', function() Slivers.misc.open_url 'https://github.com/copilot' end, { desc = 'Copilot' })

-- OpenAI
map(
  'n',
  '<leader>oaA',
  function() Slivers.misc.open_url 'https://platform.openai.com/settings/organization/billing/overview' end,
  { desc = 'OpenAI' }
)

-- [[ Awesome ]]
-- Awesome Shadcn
map(
  'n',
  '<leader>odas',
  function() Slivers.misc.open_url 'https://github.com/birobirobiro/awesome-shadcn-ui' end,
  { desc = 'Awesome Shadcn' }
)
