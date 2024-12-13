return {
  'stevearc/dressing.nvim',
  enabled = false,
  event = 'VeryLazy',
  opts = {
    input = { default_prompt = ' ' },
    select = {
      telescope = function()
        if SliverUtils.lazy.is_available 'telescope.nvim' then
          return require('telescope.themes').get_cursor
        else
          return nil
        end
      end,
    },
  },
}
