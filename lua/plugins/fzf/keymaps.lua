local M = {
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
