return {
  {
    'echasnovski/mini.icons',
    version = false,
    lazy = true,
    enabled = vim.g.have_nerd_font,
    opts = {},
  },
  {
    'echasnovski/mini.splitjoin',
    version = false,
    event = 'VeryLazy',
    opts = {},
  },
  {
    'echasnovski/mini.pairs',
    version = false,
    event = 'InsertEnter',
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { 'string' },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    },
  },
  {
    'echasnovski/mini.ai',
    version = false,
    event = 'VeryLazy',
    opts = { n_lines = 500 },
  },
  {
    'echasnovski/mini.surround',
    version = false,
    event = 'VeryLazy',
    opts = {},
  },
  {
    'echasnovski/mini.move',
    version = false,
    event = 'VeryLazy',
    opts = {},
  },
}
