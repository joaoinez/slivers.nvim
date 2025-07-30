---@diagnostic disable: missing-fields

local layouts = require 'plugins.snacks.picker.layouts'

local M = {
  {
    '<leader><space>',
    function()
      Snacks.picker.buffers {
        layout = {
          preset = 'bottom',
          preview = 'main',
        },
        hidden = true,
        unloaded = false,
        nofile = false,
        win = {
          input = {
            footer = '┤ <c-w> close │ <a-s> flash │ <a-g> refine ├ ',
            footer_pos = 'right',
            keys = {
              ['<c-w>'] = { 'bufdelete', mode = { 'n', 'i' } },
            },
          },
        },
      }
    end,
    desc = 'Open Buffers',
  },
  {
    '<leader>ft',
    function()
      Snacks.picker.explorer {
        hidden = true,
        ignored = true,
        layout = { cycle = false },
        auto_close = true,
      }
    end,
    desc = 'File Explorer (tree)',
  },
  {
    '<leader>ff',
    function()
      -- // TODO: Reuse this function
      Snacks.picker.files {
        hidden = true,
        matcher = {
          frecency = true,
        },
        win = {
          preview = {
            footer = '┤ <a-h> hidden │ <a-i> ignored │ <a-s> flash │ <a-g> refine ├ ',
            footer_pos = 'right',
          },
        },
      }
    end,
    desc = 'Find Files',
  },
  {
    '<leader>fd',
    function()
      local current_dir = vim.fn.expand '%:p:h'
      if current_dir == '' or vim.fn.isdirectory(current_dir) == 0 then current_dir = vim.fn.getcwd() end
      Snacks.picker.files {
        cwd = current_dir,
        win = {
          preview = {
            footer = '┤ <a-h> hidden │ <a-i> ignored │ <a-s> flash ├ ',
            footer_pos = 'right',
          },
        },
      }
    end,
    desc = 'Find Files (cwd)',
  },
  {
    '<leader>fg',
    function()
      Snacks.picker.grep {
        hidden = true,
        layout = layouts.dropdown({
          layout = { width = 0.8, height = 0.9 },
        }, 0.67),
        win = {
          preview = {
            footer = '┤ <a-h> hidden │ <a-i> ignored │ <a-s> flash ├ ',
            footer_pos = 'right',
          },
        },
      }
    end,
    desc = 'Grep Text',
  },
  {
    '<leader>fw',
    function()
      Snacks.picker.grep_word {
        layout = layouts.dropdown({
          layout = { width = 0.8, height = 0.9 },
        }, 0.67),
        win = {
          preview = {
            footer = '┤ <a-h> hidden │ <a-i> ignored │ <a-s> flash ├ ',
            footer_pos = 'right',
          },
        },
      }
    end,
    desc = 'Find Word',
  },
  {
    '<leader>fw',
    function()
      Snacks.picker.grep_word {
        layout = layouts.dropdown({
          layout = { width = 0.8, height = 0.9 },
        }, 0.67),
        win = {
          preview = {
            footer = '┤ <a-h> hidden │ <a-i> ignored │ <a-s> flash ├ ',
            footer_pos = 'right',
          },
        },
      }
    end,
    desc = 'Find Selection',
    mode = 'x',
  },
  {
    '<leader>fm',
    function()
      Snacks.picker.marks {
        layout = {
          preset = 'bottom',
          preview = 'main',
        },
        global = true,
        ['local'] = true,
        ---@type snacks.picker.transform
        transform = function(item)
          if item.text:match '^[0-9\'"%[%]^<>`.]' then return false end
          return item
        end,
        win = { input = { footer = '┤ <a-s> flash ├ ', footer_pos = 'right' } },
      }
    end,
    desc = 'Find Marks',
  },
  { '<leader>f/', function() Snacks.picker.lines() end, desc = 'Search' },
  {
    '<leader>fy',
    function() Snacks.terminal('yazi', { win = { border = 'rounded' } }) end,
    desc = 'File Explorer (yazi)',
  },
}

return M
