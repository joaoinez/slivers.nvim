local M = {
  {
    '<leader><space>',
    function()
      Snacks.picker.buffers {
        layout = {
          preset = 'ivy',
          preview = 'main',
        },
        hidden = true,
        unloaded = false,
        nofile = false,
        win = {
          preview = {
            footer = '┤ <c-w> close │ <a-s> flash │ <a-g> refine ├ ',
            footer_pos = 'left',
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
    '<leader>ff',
    function()
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
    '<leader>ft',
    function()
      Snacks.picker.grep {
        layout = 'bottom',
        win = {
          preview = {
            footer = '┤ <a-h> hidden │ <a-i> ignored │ <a-s> flash ├ ',
            footer_pos = 'left',
          },
        },
      }
    end,
    desc = 'Find Text',
  },
  {
    '<leader>fw',
    function()
      Snacks.picker.grep_word {
        layout = 'bottom',
        win = {
          preview = {
            footer = '┤ <a-h> hidden │ <a-i> ignored │ <a-s> flash ├ ',
            footer_pos = 'left',
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
        layout = 'bottom',
        win = {
          preview = {
            footer = '┤ <a-h> hidden │ <a-i> ignored │ <a-s> flash ├ ',
            footer_pos = 'left',
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
          preset = 'ivy',
          preview = 'main',
        },
        global = true,
        ['local'] = true,
        ---@type snacks.picker.transform
        transform = function(item)
          if item.text:match '^[0-9\'"%[%]^<>`.]' then return false end
          return item
        end,
        win = { preview = { footer = '┤ <a-s> flash ├ ', footer_pos = 'left' } },
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
