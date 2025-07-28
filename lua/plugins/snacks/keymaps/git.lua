---@diagnostic disable: missing-fields

local layouts = require 'plugins.snacks.picker.layouts'

local M = {
  {
    '<leader>gb',
    function()
      Snacks.picker.git_branches {
        layout = 'vscode',
        win = { input = { footer = '┤ <c-a> add │ <c-x> delete ├ ', footer_pos = 'right' } },
      }
    end,
    desc = 'Git Branches',
  },
  {
    '<leader>gs',
    function()
      Snacks.picker.git_status {
        layout = layouts.default({}, 0.67),
        win = {
          input = {
            keys = {
              ['<c-g>'] = {
                'neogit_open',
                mode = { 'n', 'i' },
              },
              ['<c-c>'] = {
                'neogit_commit',
                mode = { 'n', 'i' },
              },
            },
          },
          preview = {
            footer = '┤ <tab> (un)stage │ <c-g> git │ <c-c> commit ├ ',
            footer_pos = 'right',
          },
        },
        actions = {
          neogit_open = function() require('neogit').open() end,
          neogit_commit = function(picker)
            require('neogit').open { 'commit' }
            picker:close()
          end,
        },
      }
    end,
    desc = 'Git Status',
  },
  {
    '<leader>gl',
    function()
      Snacks.picker.git_log {
        layout = layouts.dropdown({ layout = { width = 0.8, height = 0.9 } }, 0.75),
      }
    end,
    desc = 'Log',
  },
  {
    '<leader>gh',
    function() Snacks.picker.git_log_file() end,
    desc = 'History (file)',
  },
  {
    '<leader>g/',
    function() Snacks.terminal('git hook run pre-commit', { auto_close = false, win = { border = 'rounded' } }) end,
    desc = 'Run `pre-commit` hook',
  },
  { '<leader>gG', function() Snacks.lazygit() end, desc = 'Lazygit' },
  { '<leader>gB', function() Snacks.gitbrowse { what = 'repo' } end, desc = 'Browse Repo (github)' },
  { '<leader>gx', function() Snacks.gitbrowse() end, desc = 'Browse Repo (github)' },
  {
    '<leader>go',
    function() Snacks.terminal('gh pr create', { win = { border = 'rounded' } }) end,
    desc = 'Open PR (github)',
  },
}

return M
