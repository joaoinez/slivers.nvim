local cmd = vim.api.nvim_create_user_command

-- [[ User Commands ]]

if not vim.g.vscode then
  -- Update Everything
  cmd('UpdateEverything', function()
    vim.cmd ':Lazy update'
    vim.cmd ':TSUpdate'
    vim.cmd ':MasonToolsUpdate'
  end, { desc = 'Update lazy, treesitter and mason' })

  -- Lua function to dump colorschemes to the clipboard
  -- vim.api.nvim_create_user_command('DumpColorschemesToClipboard', function()
  --   local schemes = vim.fn.split(vim.fn.globpath(vim.o.runtimepath, 'colors/*.vim'), '\n')
  --   schemes = vim.fn.map(schemes, function(_, val) return vim.fn.fnamemodify(val, ':t:r') end)
  --   local clipboard_contents = table.concat(schemes, '\n')
  --
  --   if vim.fn.has 'mac' == 1 then
  --     vim.fn.system('echo "' .. clipboard_contents .. '" | pbcopy')
  --   elseif vim.fn.has 'unix' == 1 then
  --     if vim.fn.executable 'xclip' == 1 then
  --       vim.fn.system('echo "' .. clipboard_contents .. '" | xclip -selection clipboard')
  --     elseif vim.fn.executable 'wl-copy' == 1 then
  --       vim.fn.system('echo "' .. clipboard_contents .. '" | wl-copy')
  --     else
  --       print 'No suitable clipboard utility found (xclip/wl-copy).'
  --     end
  --   end
  --
  --   print 'Colorschemes copied to clipboard.'
  -- end, { desc = 'Dump all available colorschemes to the clipboard' })
end
