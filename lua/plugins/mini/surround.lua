---@type LazySpec
return {
  'echasnovski/mini.surround',
  enabled = true,
  version = false,
  event = 'VeryLazy',
  opts = {
    mappings = {
      add = 'ms', -- Add surrounding in Normal and Visual modes
      delete = 'md', -- Delete surrounding
      find = 'mf', -- Find surrounding (to the right)
      find_left = 'mF', -- Find surrounding (to the left)
      highlight = 'mh', -- Highlight surrounding
      replace = 'mr', -- Replace surrounding
      update_n_lines = 'mn', -- Update `n_lines`
    },
  },
}
