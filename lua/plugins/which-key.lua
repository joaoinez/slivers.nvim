return {
  'folke/which-key.nvim',
  enabled = true,
  event = 'VeryLazy',
  keys = {
    {
      '<leader>?',
      function() require('which-key').show { global = false } end,
      desc = 'Local Keymaps',
    },
  },
  opts = {
    preset = 'helix',
    spec = {
      -- [[ Actions ]]
      -- Breakpoint
      { '<leader>b', icon = { icon = '', color = 'red' } },

      -- Harpoon
      { '<leader>h', icon = { icon = '󱡀', color = 'azure' } },

      -- Keywordprg
      { '<leader>K', icon = { icon = '', color = 'grey' } },

      -- Minimap
      { '<leader>M', icon = { icon = '', color = 'purple' } },

      -- Neovim news
      { '<leader>N', icon = { icon = '󰎕', color = 'grey' } },

      -- Command Palette
      { '<leader>p', icon = { icon = '', color = 'cyan' } },

      -- Compiler
      { '<leader>r', icon = { icon = '', color = 'green' } },
      { '<leader>R', icon = { icon = '', color = 'green' } },

      -- Save file
      { '<leader>s', icon = { icon = '󰆓', color = 'azure' } },

      -- Yank file
      { '<leader>y', icon = { icon = '󰆏', color = 'azure' } },

      -- Comment code
      { '<leader>/', icon = { icon = '󰦨', color = 'grey' } },

      -- Commands
      { '<leader>:', icon = { icon = '', color = 'green' } },

      -- Keymaps
      { '<leader>?', icon = { icon = '', color = 'grey' } },

      -- Splits
      { '<leader>\\', icon = { icon = '', color = 'purple' } },
      { '<leader>|', icon = { icon = '', color = 'purple' } },

      -- Open buffers
      { '<leader><leader>', icon = { icon = '󱊔', color = 'azure' } },

      -- [[ Groups ]]
      -- Code
      { '<leader>c', group = 'code', mode = { 'n', 'x' } },
      { '<leader>ca', icon = { icon = '󱐋', color = 'orange' } },
      { '<leader>cA', icon = { icon = '', color = 'orange' } },
      { '<leader>cd', icon = { icon = '󰙅', color = 'green' } },
      { '<leader>cf', icon = { icon = '󰉺', color = 'azure' } },
      { '<leader>cI', icon = { icon = '', color = 'azure' } },
      { '<leader>cr', icon = { icon = '', color = 'blue' } },
      { '<leader>cR', icon = { icon = '', color = 'azure' } },
      { '<leader>cs', icon = { icon = '󰀫', color = 'green' } },
      { '<leader>cW', icon = { icon = '', color = 'blue' } },

      -- Debug
      { '<leader>d', group = 'debug', mode = { 'n', 'v' } },
      { '<leader>dB', icon = { icon = '', color = 'red' } },
      { '<leader>dc', icon = { icon = '', color = 'green' } },
      { '<leader>di', icon = { icon = '', color = 'green' } },
      { '<leader>dl', icon = { icon = '', color = 'green' } },
      { '<leader>do', icon = { icon = '', color = 'green' } },
      { '<leader>dO', icon = { icon = '', color = 'green' } },
      { '<leader>dp', icon = { icon = '', color = 'yellow' } },
      { '<leader>dr', icon = { icon = '', color = 'green' } },
      { '<leader>dt', icon = { icon = '', color = 'red' } },

      -- Find
      { '<leader>f', group = 'find', mode = { 'n', 'v' } },
      { '<leader>ff', icon = { icon = '', color = 'green' } },
      { '<leader>fe', icon = { icon = '󰙅', color = 'purple' } },
      { '<leader>fh', icon = { icon = '󱡀', color = 'azure' } },
      { '<leader>fH', icon = { icon = '󰋖', color = 'grey' } },
      { '<leader>ft', icon = { icon = '', color = 'blue' } },
      { '<leader>f?', icon = { icon = '', color = 'grey' } },

      -- Git
      { '<leader>g', group = 'git', icon = { icon = '󰊢', color = 'orange' }, mode = { 'n', 'v' } },
      { '<leader>gB', icon = { icon = '󰊤', color = 'grey' } },
      { '<leader>gg', icon = { icon = '', color = 'blue' } },

      -- Messages
      { '<leader>m', group = 'messages', icon = { icon = '󰍡', color = 'purple' } },
      { '<leader>mh', icon = { icon = '󰍡', color = 'purple' } },

      -- Quickfix/Diagnostics
      { '<leader>q', group = 'quickfix/diagnostics' },
      { '<leader>ql', icon = { icon = '󰙅', color = 'red' } },
      { '<leader>qQ', icon = { icon = '󰙅', color = 'red' } },
      { '<leader>qx', icon = { icon = '󰙅', color = 'red' } },
      { '<leader>qX', icon = { icon = '󰙅', color = 'red' } },

      -- Toggles
      { '<leader>t', group = 'toggle' },
      { '<leader>tD', icon = { icon = '󰊢', color = 'red' } },
      { '<leader>tm', icon = { icon = '', color = 'purple' } },
      { '<leader>tt', icon = { icon = '', color = 'red' } },

      -- AI
      { '<leader>a', group = 'ai', icon = { icon = '', color = 'cyan' }, mode = { 'n', 'v' } },

      -- Settings
      { '<leader>,', group = 'settings', icon = { icon = '󰒓', color = 'grey' } },
      { '<leader>,m', icon = { icon = '󱌢', color = 'orange' } },
      { '<leader>,M', icon = { icon = '󱌢', color = 'orange' } },
      { '<leader>,t', icon = { icon = '󰔱', color = 'green' } },
      { '<leader>,T', icon = { icon = '󰔱', color = 'green' } },
    },
  },
}
