return {
  cmd_env = { RUFF_TRACE = 'messages' },
  init_options = {
    settings = {
      logLevel = 'error',
    },
  },
  on_attach = function(client)
    local map = Slivers.keymaps.safe_keymap_set
    local lsp = Slivers.lsp

    map('n', '<leader>co', lsp.action['source.organizeImports'], { desc = 'Organize Imports' })

    client.server_capabilities.hoverProvider = false
  end,
}
