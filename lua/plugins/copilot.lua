---@type LazySpec
return {
  'zbirenbaum/copilot.lua',
  enabled = true,
  cond = not vim.g.vscode and vim.g.ai_completion == 'copilot',
  cmd = 'Copilot',
  event = 'InsertEnter',
  opts = {
    suggestion = {
      auto_trigger = true,
      hide_during_completion = true,
      trigger_on_accept = true,
      keymap = {
        accept = '<Tab>',
        next = '<M-]>',
        prev = '<M-[>',
        dismiss = false,
      },
    },
  },
}
