---@diagnostic disable: unused-local, missing-parameter, missing-fields

return {
  'folke/zen-mode.nvim',
  dependencies = {
    'folke/twilight.nvim',
    opts = {
      context = 16,
    },
  },
  keys = {
    {
      '<leader>tz',
      function() require('zen-mode').toggle() end,
      desc = 'Zen Mode',
    },
  },
  opts = {
    window = {
      backdrop = 1,
      width = 120,
      options = {
        signcolumn = 'no',
        number = false,
        relativenumber = false,
        cursorline = false,
        cursorcolumn = false,
        foldcolumn = '0',
        list = false,
      },
    },
  },
  plugins = {
    options = {
      enabled = true,
      ruler = false,
      showcmd = false,
      laststatus = 0,
    },
    twilight = { enabled = true },
    gitsigns = { enabled = true },
    tmux = { enabled = true },
    todo = { enabled = true },
    kitty = {
      enabled = true,
      font = '+4',
    },
  },
  on_open = function(win)
    vim.schedule(function() require('lualine').hide() end)
  end,
  on_close = function()
    vim.schedule(function() require('lualine').hide { unhide = true } end)
  end,
}
