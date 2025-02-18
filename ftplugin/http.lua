vim.api.nvim_buf_set_keymap(
  0,
  'n',
  '<cr>',
  "<cmd>lua require('kulala').run()<cr>",
  { noremap = true, silent = true, desc = 'Execute the request (kulala)' }
)

vim.api.nvim_buf_set_keymap(
  0,
  'n',
  '[r',
  "<cmd>lua require('kulala').jump_prev()<cr>",
  { noremap = true, silent = true, desc = 'Jump to the previous request (kulala)' }
)
vim.api.nvim_buf_set_keymap(
  0,
  'n',
  ']r',
  "<cmd>lua require('kulala').jump_next()<cr>",
  { noremap = true, silent = true, desc = 'Jump to the next request (kulala)' }
)

vim.api.nvim_buf_set_keymap(
  0,
  'n',
  '<leader>p',
  "<cmd>lua require('kulala').from_curl()<cr>",
  { noremap = true, silent = true, desc = 'Paste Request (curl)' }
)

vim.api.nvim_buf_set_keymap(
  0,
  'n',
  '<leader>y',
  "<cmd>lua require('kulala').copy()<cr>",
  { noremap = true, silent = true, desc = 'Copy Request (curl)' }
)

vim.api.nvim_buf_set_keymap(
  0,
  'n',
  '<leader>i',
  "<cmd>lua require('kulala').inspect()<cr>",
  { noremap = true, silent = true, desc = 'Inspect Request' }
)

Slivers.lazy.on_load('which-key.nvim', function()
  vim.schedule(
    function()
      require('which-key').add {
        {
          '<leader>p',
          icon = { icon = '󰆒' },
        },
        {
          '<leader>y',
          icon = { icon = '󰆏' },
        },
        {
          '<leader>i',
          icon = { icon = '󱎸' },
        },
      }
    end
  )
end)
