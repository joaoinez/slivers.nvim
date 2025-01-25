-- [[ VSCode Setup ]]
local vscode = require 'vscode'
local map = Slivers.keymaps.safe_keymap_set

vim.notify = vscode.notify

-- Move Lines
map(
  { 'n', 'v', 'i' },
  '<A-j>',
  function() vscode.action 'editor.action.moveLinesDownAction' end,
  { desc = 'Move Down' }
)
map({ 'n', 'v', 'i' }, '<A-k>', function() vscode.action 'editor.action.moveLinesUpAction' end, { desc = 'Move Up' })

-- Toggle comments
map(
  { 'n', 'x' },
  '<leader>/',
  function() vscode.action 'editor.action.commentLine' end,
  { desc = 'Toggle comment line' }
)

-- Open file picker
map(
  'n',
  '<leader>ff',
  function() require('vscode').action 'workbench.action.quickOpen' end,
  { desc = 'Open File Explorer' }
)
map(
  'n',
  '<leader>|',
  function() vim.cmd('lua vscode.api.commands.executeCommand({ commandId = "workbench.action.splitEditorVertically" })') end,
  { desc = 'Split Editor Vertically' }
)

-- Buffer list
map('n', '<leader>bb', function() require('vscode').action 'workbench.action.showOpenFiles' end, { desc = 'Show Buffer List' })
