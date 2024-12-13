---@diagnostic disable: missing-fields

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = {
      enabled = true,
      setup = function(ctx)
        vim.cmd [[NoMatchParen]]
        Snacks.util.wo(0, { foldmethod = 'manual', statuscolumn = '', conceallevel = 0 })
        vim.b.minianimate_disable = true
        vim.b.minimap_disable = true
        vim.schedule(function() vim.bo[ctx.buf].syntax = ctx.ft end)
      end,
    },
    dashboard = {
      enabled = true,
      pane_gap = 8,
      preset = {
        keys = {
          { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
          { icon = ' ', key = 't', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = '󰙅 ', key = 'e', desc = 'Explore Files', action = ':Oil' },
          {
            icon = ' ',
            key = 'c',
            desc = 'Config',
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
          { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
          { icon = '󱌢 ', key = 'm', desc = 'Mason', action = ':Mason' },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
        header = [[


           ▄ ▄                   
       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     
       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     
    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     
  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  
  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄
▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █
█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █
    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    
]],
      },
      formats = {
        header = { '%s', align = 'center', hl = 'SnacksDashboardFooter' },
      },
      sections = {
        { section = 'header' },
        { title = 'Quick Actions', padding = 1, align = 'center' },
        { section = 'keys', gap = 2, padding = 1 },
        { pane = 2, text = '', padding = 4 },
        { pane = 2, section = 'terminal', cmd = 'gh contrib --style dot', height = 5, padding = 4, indent = 4 },
        { pane = 2, title = 'More Actions', padding = 1, align = 'center' },
        { pane = 2, icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
        { pane = 2, icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
        {
          pane = 2,
          icon = ' ',
          desc = 'Browse Repo (open)',
          padding = 1,
          key = 'b',
          action = function() Snacks.gitbrowse() end,
        },
        {
          pane = 2,
          icon = ' ',
          title = 'Git Status',
          section = 'terminal',
          enabled = function() return Snacks.git.get_root() ~= nil end,
          cmd = 'hub --no-pager diff --stat -B -M -C',
          key = 'g',
          action = function() Snacks.lazygit() end,
          height = 10,
          padding = 1,
          indent = 3,
        },
        { pane = 2, section = 'startup' },
      },
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    -- terminal = {
    --   win = { height = 0.3 },
    -- },
    words = { enabled = true },
  },
  keys = {
    { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit' },
    { '<leader>gf', function() Snacks.lazygit.log_file() end, desc = 'Current File History (lazygit)' },
    -- {
    --   '<leader>gl',
    --   function() Snacks.lazygit.log { cwd = LazyVim.root.git() } end,
    --   desc = 'Git Log (lazygit)',
    -- },
    { '<leader>gf', function() Snacks.lazygit() end, desc = 'Current File History (lazygit)' },
    { '<leader>gB', function() Snacks.gitbrowse() end, desc = 'Git Browse (open)' },
    {
      '<leader>N',
      desc = 'Neovim News',
      function()
        Snacks.win {
          file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = 'yes',
            statuscolumn = ' ',
            conceallevel = 3,
          },
        }
      end,
    },
    { '<leader>tt', function() Snacks.terminal() end, desc = 'Terminal' },
    { '<C-_>', function() Snacks.terminal() end, desc = 'which_key_ignore' },
    { ']]', function() Snacks.words.jump(vim.v.count1) end, desc = 'Next Reference (snacks)', mode = { 'n', 't' } },
    { '[[', function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev Reference (snacks)', mode = { 'n', 't' } },
  },
}
