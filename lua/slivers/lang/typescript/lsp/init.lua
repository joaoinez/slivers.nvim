---@diagnostic disable: missing-fields, redundant-return-value

local M = {}

function M.get_servers()
  local volar = require 'slivers.lang.typescript.lsp.vue'

  local servers = {
    eslint = require 'slivers.lang.typescript.lsp.eslint',
    tailwindcss = require 'slivers.lang.typescript.lsp.tailwind',
    volar = volar.config,
    vtsls = require 'slivers.lang.typescript.lsp.typescript',
  }

  table.insert(servers.vtsls.settings.vtsls.tsserver.globalPlugins, volar.plugin)

  return servers
end

return M
