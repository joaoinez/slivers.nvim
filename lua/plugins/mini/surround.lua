---@type LazySpec
return {
  'nvim-mini/mini.surround',
  enabled = true,
  cond = true,
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

      suffix_last = 'l', -- Suffix to search with "prev" method
      suffix_next = 'n', -- Suffix to search with "next" method
    },
  },
}
