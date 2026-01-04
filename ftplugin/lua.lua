vim.api.nvim_buf_set_keymap(0, 'n', '<leader>cl', '', {
  noremap = true,
  silent = true,
  desc = 'Console log word under cursor',
  callback = function()
    local word = vim.fn.expand '<cword>'

    vim.cmd('normal!o' .. 'print(' .. word .. ');')
  end,
})
