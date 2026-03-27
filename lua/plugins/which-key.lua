---@type LazySpec
return {
  'folke/which-key.nvim',
  enabled = true,
  cond = not vim.g.vscode,
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
    triggers = {
      { '<auto>', mode = 'nixsotc' },
      { 'm', mode = { 'n', 'v' } },
    },
    spec = {
      -- [[ Actions ]]
      -- Breakpoint
      { '<leader>b', icon = { icon = '', color = 'red' } },

      -- Mark
      { '<leader>m', icon = { icon = '󱡀', color = 'azure' } },

      -- -- Compiler
      -- { '<leader>r', icon = { icon = '', color = 'green' } },
      -- { '<leader>R', icon = { icon = '', color = 'green' } },

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
      { '<leader>\\', icon = { icon = '', color = 'purple' } },
      { '<leader>|', icon = { icon = '', color = 'purple' } },

      -- Open buffers
      { '<leader><leader>', icon = { icon = '󱊔', color = 'azure' } },

      -- [[ Groups ]]
      -- AI
      { '<leader>a', group = 'ai', icon = { icon = '', color = 'white' }, mode = { 'n', 'v' } },

      -- Code
      { '<leader>c', group = 'code', mode = { 'n', 'x' } },
      { '<leader>ca', icon = { icon = '󱐋', color = 'orange' } },
      { '<leader>cA', icon = { icon = '', color = 'orange' } },
      { '<leader>cd', icon = { icon = '󰙅', color = 'green' } },
      { '<leader>cf', icon = { icon = '󰉺', color = 'azure' } },
      { '<leader>cI', icon = { icon = '', color = 'azure' } },
      { '<leader>cr', icon = { icon = '', color = 'blue' } },
      -- { '<leader>cR', icon = { icon = '', color = 'azure' } },
      { '<leader>cs', icon = { icon = '󰀫', color = 'green' } },
      { '<leader>cW', icon = { icon = '', color = 'blue' } },

      -- Debug
      { '<leader>d', group = 'debug', mode = { 'n', 'v' } },
      { '<leader>dB', icon = { icon = '', color = 'red' } },
      { '<leader>dc', icon = { icon = '', color = 'green' } },
      { '<leader>di', icon = { icon = '', color = 'green' } },
      { '<leader>dl', icon = { icon = '', color = 'green' } },
      { '<leader>ds', icon = { icon = '', color = 'green' } },
      { '<leader>dO', icon = { icon = '', color = 'green' } },
      { '<leader>dp', icon = { icon = '', color = 'yellow' } },
      { '<leader>dr', icon = { icon = '', color = 'green' } },
      { '<leader>dt', icon = { icon = '', color = 'red' } },

      -- Find
      { '<leader>f', group = 'find', mode = { 'n', 'v' } },
      { '<leader>fr', group = 'replace', mode = { 'n', 'v' } },
      { '<leader>ff', icon = { icon = '', color = 'green' } },
      { '<leader>fs', icon = { icon = '', color = 'green' } },
      { '<leader>fe', icon = { icon = '󰙅', color = 'purple' } },
      { '<leader>fo', icon = { icon = '󰙅', color = 'purple' } },
      { '<leader>ft', icon = { icon = '󰙅', color = 'purple' } },
      { '<leader>fy', icon = { icon = '󰙅', color = 'purple' } },
      { '<leader>fm', icon = { icon = '󱡀', color = 'azure' } },
      { '<leader>fh', icon = { icon = '󰋖', color = 'grey' } },
      { '<leader>fM', icon = { icon = '', color = 'grey' } },
      { '<leader>fg', icon = { icon = '', color = 'blue' } },
      { '<leader>f?', icon = { icon = '', color = 'grey' } },

      -- Git
      { '<leader>g', group = 'git', icon = { icon = '󰊢', color = 'orange' }, mode = { 'n', 'v' } },
      { '<leader>gB', icon = { icon = '󰊤', color = 'grey' } },
      { '<leader>gg', icon = { icon = '', color = 'blue' } },

      -- Open
      { '<leader>o', group = 'open', icon = { icon = '󰌹', color = 'azure' } },
      { '<leader>of', group = 'file', icon = { icon = '', color = 'cyan' } },
      { '<leader>ofc', icon = { icon = '', color = 'cyan' } },
      { '<leader>ofz', icon = { icon = '', color = 'cyan' } },
      { '<leader>oa', group = 'ai' },
      { '<leader>oi', group = 'icons', icon = { icon = '󱌝', color = 'azure' } },
      { '<leader>op', group = 'deployment', icon = { icon = '', color = 'azure' } },
      { '<leader>od', group = 'documentation', icon = { icon = '', color = 'grey' } },
      { '<leader>ou', group = 'ui' },
      { '<leader>ou2', icon = { icon = '', color = 'yellow' } },
      { '<leader>oua', icon = { icon = '', color = 'yellow' } },
      { '<leader>oum', icon = { icon = '', color = 'yellow' } },
      { '<leader>ouM', icon = { icon = '', color = 'yellow' } },
      { '<leader>oda', group = 'awesome', icon = { icon = '󰓠', color = 'red' } },

      -- Misc
      { '<leader>k', group = 'misc', icon = { icon = '', color = 'purple' } },
      -- { '<leader>kd', icon = { icon = '󰾡', color = 'yellow' } },
      { '<leader>kk', icon = { icon = '', color = 'grey' } },
      { '<leader>km', icon = { icon = '󱡀', color = 'azure' } },
      { '<leader>ks', icon = { icon = '󰢱', color = 'blue' } },
      { '<leader>kT', icon = { icon = '', color = 'blue' } },
      { '<leader>kp', icon = { icon = '', color = 'cyan' } },
      { '<leader>kc', group = 'colorpicker' },
      { '<leader>kR', group = 'repl', icon = { icon = '', color = 'orange' } },

      -- Messages
      { '<leader>N', group = 'messages', icon = { icon = '󰍡', color = 'purple' } },

      -- Quicklist/Diagnostics
      { '<leader>q', group = 'quicklist/diagnostics' },
      { '<leader>ql', icon = { icon = '󰙅', color = 'red' } },
      { '<leader>qQ', icon = { icon = '󰙅', color = 'red' } },
      { '<leader>qx', icon = { icon = '󰙅', color = 'red' } },
      { '<leader>qX', icon = { icon = '󰙅', color = 'red' } },
      { '<leader>qp', group = 'project diagnostics' },

      -- Toggles
      { '<leader>t', group = 'toggle' },
      { '<leader>tt', icon = { icon = '', color = 'red' } },
      { '<leader>tS', icon = { icon = '', color = 'purple' } },

      -- Settings
      { '<leader>,', group = 'settings', icon = { icon = '󰒓', color = 'grey' } },
      { '<leader>,m', icon = { icon = '󱌢', color = 'orange' } },
      { '<leader>,M', icon = { icon = '󱌢', color = 'orange' } },
      { '<leader>,n', icon = { icon = '󰎕', color = 'grey' } },
      { '<leader>,t', icon = { icon = '󰔱', color = 'green' } },
      { '<leader>,T', icon = { icon = '󰔱', color = 'green' } },

      -- [[ Proxies ]]
      { '<leader>ky', group = 'proxy', icon = { icon = '', color = 'white' } },
      { '<leader>kyg', proxy = 'g', group = 'goto/comments/case/splitjoin/conflicts' },
      { '<leader>kyp', proxy = '[', group = 'previous ...' },
      { '<leader>kyn', proxy = ']', group = 'next ...' },
      { '<leader>kys', proxy = 's', group = 'surround' },
      { '<leader>kyw', proxy = '<C-w>', group = 'wincmds' },
      { '<leader>kyz', proxy = 'z', group = 'folds/center screen' },

      -- [[ Windows ]]
      { '<leader>w', group = 'windows' },
    },
  },
}
