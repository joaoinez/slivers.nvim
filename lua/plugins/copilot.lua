---@type LazySpec
return {
  'zbirenbaum/copilot.lua',
  dependencies = {
    'copilotlsp-nvim/copilot-lsp',
  },
  enabled = true,
  cond = not vim.g.vscode,
  cmd = 'Copilot',
  event = 'InsertEnter',
  opts = {
    panel = { enabled = false },
    nes = { enabled = false },
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = '<Tab>',
        next = '<M-]>',
        prev = '<M-[>',
        dismiss = false,
      },
    },
  },
}
