---@diagnostic disable: missing-fields

---@type LazySpec
return vim.g.dev
    and {
      -- {
      --   dir = vim.fn.has 'macunix' == 1 and '~/Projects/arco-iris.nvim' or '~/Documents/Projects/arco-iris.nvim',
      --   enabled = vim.g.dev,
      --   cond = not vim.g.vscode,
      --   priority = 1001,
      --   lazy = false,
      --   keys = {
      --     {
      --       '<leader>,c',
      --       '<cmd>ArcoIris pick<cr>',
      --       desc = 'Colorschemes',
      --     },
      --   },
      --   opts = {
      --     callback = function() ColorSliver() end,
      --   },
      -- },
    }
  or {}
