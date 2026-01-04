local cmd = vim.api.nvim_create_user_command

-- [[ User Commands ]]

if not vim.g.vscode then
  -- Update Everything
  cmd('UpdateEverything', function()
    vim.cmd ':Lazy update'
    vim.cmd ':TSUpdate'
    vim.cmd ':MasonToolsUpdate'
  end, { desc = 'Update lazy, treesitter and mason' })
end
