---@diagnostic disable: missing-fields

local layouts = require 'plugins.snacks.picker.layouts'

local M = {
  {
    '<leader>gb',
    function()
      Snacks.picker.git_branches {
        all = true,
        layout = 'vscode',
        win = { input = { footer = '┤ <c-a> add │ <c-x> delete ├ ', footer_pos = 'right' } },
      }
    end,
    desc = 'Branches',
  },
  {
    '<leader>gs',
    function()
      local file = vim.fn.expand '%:.'
      Snacks.picker.git_status {
        layout = layouts.default({}, 0.67),
        on_show = function(picker)
          if file == '' then return end

          for i, item in ipairs(picker:items()) do
            if item.file == file then
              picker.list:view(i)
              break
            end
          end
        end,
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
          neogit_open = function()
            vim.cmd 'stopinsert'
            require('neogit').open()
          end,
          neogit_commit = function(picker)
            vim.cmd 'stopinsert'
            require('neogit').open { 'commit' }
            picker:close()
          end,
        },
      }
    end,
    desc = 'Status',
  },
  {
    '<leader>g#',
    function()
      Snacks.picker.git_log {
        layout = layouts.dropdown({ layout = { width = 0.8, height = 0.9 } }, 0.75),
      }
    end,
    desc = 'Commit Hashes',
  },
  --[[ {
    '<leader>gh',
    function() Snacks.picker.git_log_file() end,
    desc = 'History (file)',
  }, ]]
  {
    '<leader>g/',
    function() Snacks.terminal('git hook run pre-commit', { auto_close = false, win = { border = 'rounded' } }) end,
    desc = 'Run `pre-commit` hook',
  },
  { '<leader>gG', function() Snacks.lazygit() end, desc = 'Lazygit' },
  { '<leader>gB', function() Snacks.gitbrowse { what = 'repo' } end, desc = 'Browse Repo (branch)' },
  { '<leader>gx', function() Snacks.gitbrowse() end, desc = 'Browse File (github)' },
  {
    '<leader>gp',
    function()
      local git_root = Snacks.git.get_root()
      Snacks.terminal('git fetch && git pull', {
        cwd = git_root,
        auto_close = false,
        win = { border = 'rounded', width = 0.5, height = 0.5 },
      })
    end,
    desc = 'Pull',
  },

  { '<leader>gH', function() Snacks.terminal('gh dash', { win = { width = 0, height = 0 } }) end, desc = 'GH Dash' },
  -- { '<leader>gX', function() Snacks.gitbrowse { branch = 'main' } end, desc = 'Browse File (main)' },
  --[[ {
    '<leader>go',
    function() Snacks.terminal('opencode run main --command pr', { auto_close = false, win = { border = 'rounded' } }) end,
    desc = 'Open PR (opencode)',
  }, ]]
}

return M
