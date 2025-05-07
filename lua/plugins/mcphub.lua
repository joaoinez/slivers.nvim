---@type LazySpec
return {
  'ravitemer/mcphub.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  build = 'npm install -g mcp-hub@latest',
  cmd = { 'MCPHub' },
  keys = {
    {
      '<leader>,h',
      '<cmd>MCPHub<cr>',
      desc = 'MCP Hub',
    },
  },
  opts = {
    auto_approve = true,
    extensions = {
      avante = {
        make_slash_commands = true,
      },
    },
  },
}
