local M = {}

M.keys = {
  { '<c-j>', '<c-j>', ft = 'fzf', mode = 't', nowait = true },
  { '<c-k>', '<c-k>', ft = 'fzf', mode = 't', nowait = true },
  { '<leader>p', '<cmd>FzfLua<cr>', desc = 'Command Palette' },
  {
    '<leader><leader>',
    '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>',
    desc = 'Open Buffers',
  },
  { '<leader>:', '<cmd>FzfLua commands<cr>', desc = 'Commands' },
  { '<leader>ff', '<cmd>FzfLua files<cr>', desc = 'Find Files' },
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
  { '<leader>fw', '<cmd>FzfLua grep_cword<cr>', desc = 'Find Word (project)' },
  { '<leader>fw', '<cmd>FzfLua grep_visual<cr>', mode = 'v', desc = 'Find Selection (project)' },
  {
    '<leader>,c',
    function()
      require('fzf-lua').colorschemes {
        complete = function(selected)
          local options_path = os.getenv 'HOME' .. '/.config/nvim/lua/slivers/options.lua'
          local colorscheme = selected[1]
          local old_colorscheme = vim.g.colorscheme
          local colorscheme_configs = ColorSliver.configs
          local old_colorscheme_config = colorscheme_configs[old_colorscheme]
          local colorscheme_config = colorscheme_configs[colorscheme]

          -- Disable old colorscheme
          if old_colorscheme_config and old_colorscheme ~= colorscheme_config then
            local old_colorscheme_path = os.getenv 'HOME'
              .. string.format('/.config/nvim/lua/plugins/%s.lua', old_colorscheme_config)

            vim.fn.system(string.format([[sed -i "s/lazy = false,/lazy = true,/" %s]], old_colorscheme_path))
            vim.fn.system(string.format([[sed -i "s/priority = 1000,/-- priority = 1000,/" %s]], old_colorscheme_path))
          end

          -- Enable new colorscheme
          if colorscheme_config and colorscheme_config ~= old_colorscheme_config then
            local colorscheme_path = os.getenv 'HOME'
              .. string.format('/.config/nvim/lua/plugins/%s.lua', colorscheme_config)

            vim.fn.system(string.format([[sed -i "s/lazy = true,/lazy = false,/" %s]], colorscheme_path))
            vim.fn.system(string.format([[sed -i "s/-- priority = 1000,/priority = 1000,/" %s]], colorscheme_path))
          end

          -- Apply new colorscheme
          -- TODO: Load hl groups here
          vim.cmd.colorscheme(colorscheme)
          vim.fn.system(
            string.format(
              [[sed -i "s/vim\.g\.colorscheme = '[^']*'/vim\.g\.colorscheme = '%s'/" %s]],
              colorscheme,
              options_path
            )
          )
        end,
      }
    end,
    desc = 'Switch Colorscheme',
  },
}

return M
