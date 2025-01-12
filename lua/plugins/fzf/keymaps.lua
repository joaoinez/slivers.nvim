local M = {
  { '<c-j>', '<c-j>', ft = 'fzf', mode = 't', nowait = true },
  { '<c-k>', '<c-k>', ft = 'fzf', mode = 't', nowait = true },
  { '<leader>kp', '<cmd>FzfLua<cr>', desc = 'Command Palette' },
  {
    '<leader><leader>',
    '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>',
    desc = 'Open Buffers',
  },
  { '<leader>:', '<cmd>FzfLua commands<cr>', desc = 'Commands' },
  { '<leader>ff', '<cmd>FzfLua files<cr>', desc = 'Find Files' },
  {
    '<leader>fd',
    function()
      local current_dir = vim.fn.expand '%:p:h'
      if current_dir == '' or vim.fn.isdirectory(current_dir) == 0 then current_dir = vim.fn.getcwd() end
      require('fzf-lua').files { cwd = current_dir }
    end,
    desc = 'Find Files (cwd)',
  },
  { '<leader>fg', '<cmd>FzfLua git_status<cr>', desc = 'Git Status' },
  { '<leader>fA', '<cmd>FzfLua autocmds<cr>', desc = 'Auto Commands' },
  { '<leader>f/', '<cmd>FzfLua grep_curbuf<cr>', desc = 'Search' },
  { '<leader>fc', '<cmd>FzfLua command_history<cr>', desc = 'Command History' },
  { '<leader>ft', '<cmd>FzfLua live_grep<cr>', desc = 'Find Text (project)' },
  { '<leader>fH', '<cmd>FzfLua help_tags<cr>', desc = 'Help Pages' },
  { '<leader>fj', '<cmd>FzfLua jumps<cr>', desc = 'Jumplist' },
  { '<leader>f?', '<cmd>FzfLua keymaps<cr>', desc = 'Keymaps' },
  { '<leader>fM', '<cmd>FzfLua man_pages<cr>', desc = 'Man Pages' },
  { '<leader>f.', '<cmd>FzfLua resume<cr>', desc = 'Resume Search' },
  { '<leader>f,', function() require('fzf-lua').files { cwd = vim.fn.stdpath 'config' } end, desc = 'Neovim Config' },
  { '<leader>fw', '<cmd>FzfLua grep_cword<cr>', desc = 'Find Word (project)' },
  { '<leader>fw', '<cmd>FzfLua grep_visual<cr>', mode = 'v', desc = 'Find Selection (project)' },
  -- {
  --   '<leader>,c',
  --   function()
  --     require('fzf-lua').colorschemes {
  --       complete = function(selected)
  --         local path = vim.fn.stdpath 'config' .. '/.slivers.json'
  --         local colorscheme = selected[1]
  --
  --         -- Apply new colorscheme
  --         local config = vim.json.decode(Slivers.misc.read_file(path))
  --         config.colorscheme = colorscheme
  --
  --         Slivers.misc.write_file(path, vim.json.encode(config))
  --
  --         vim.g.colors_name = colorscheme
  --
  --         ColorSliver()
  --
  --         -- Info notification
  --         Slivers.actions.notify(
  --           'Some colors might have not been applied.\nRestart Neovim to fully apply the colorscheme.',
  --           2
  --         )
  --       end,
  --     }
  --   end,
  --   desc = 'Switch Colorscheme',
  -- },
}

return M
