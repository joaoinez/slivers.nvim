-- [[ VSCode Setup ]]
local vscode = require 'vscode'
local map = Slivers.keymaps.safe_keymap_set

vim.notify = vscode.notify

map(
  { 'n', 'x' },
  '<leader>/',
  function() vscode.action 'editor.action.commentLine' end,
  { desc = 'Toggle comment line' }
)

map(
  'n',
  '<leader>ff',
  function() require('vscode').action 'workbench.action.quickOpen' end,
  { desc = 'Open File Picker' }
)

map(
  'n',
  '<leader>fe',
  function() require('vscode').action 'workbench.action.toggleSidebarVisibility' end,
  { desc = 'Open File Explorer' }
)

map(
  'n',
  '<leader><leader>',
  function() vscode.action 'workbench.action.quickOpenPreviousRecentlyUsedEditor' end,
  { desc = 'Opened Files' }
)

map('n', '<leader><Tab>', function() vscode.action 'workbench.action.nextEditorInGroup' end, { desc = 'Opened Files' })

map('n', '<leader>x', function()
  vscode.action 'workbench.action.files.saveAll'
  vscode.action 'workbench.action.quit'
end, { desc = 'Save and Quit VSCode' })

map(
  'n',
  '<leader>|',
  function() vscode.action 'workbench.action.splitEditorRight' end,
  { desc = 'Split Window Vertically' }
)

map(
  'n',
  '<leader>\\',
  function() vscode.action 'workbench.action.splitEditorDown' end,
  { desc = 'Split Window Horizontally' }
)

map(
  'n',
  '<leader>wq',
  function() vscode.action 'workbench.action.closeActiveEditor' end,
  { desc = 'Close Current File' }
)

map(
  'n',
  '<leader>wa',
  function() vscode.action 'workbench.action.closeOtherEditors' end,
  { desc = 'Close All Unpinned Files' }
)

map('n', '<leader>h', function() vscode.action 'workbench.action.pinEditor' end, { desc = 'Pin Current File' })
map('n', '<leader>fh', function() vscode.action 'workbench.action.unpinEditor' end, { desc = 'Unpin Current File' })
