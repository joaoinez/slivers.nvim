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
  '<leader>kR',
  "<cmd>lua require('kulala').from_curl()<cr>",
  { noremap = true, silent = true, desc = 'Paste Request (curl)' }
)
