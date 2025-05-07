local M = {}

vim.list_extend(M, require 'plugins.snacks.keymaps.files')
vim.list_extend(M, require 'plugins.snacks.keymaps.git')
vim.list_extend(M, require 'plugins.snacks.keymaps.finders')
vim.list_extend(M, require 'plugins.snacks.keymaps.misc')
vim.list_extend(M, require 'plugins.snacks.keymaps.terminal')

return M
