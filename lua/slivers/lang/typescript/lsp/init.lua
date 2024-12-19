---@diagnostic disable: missing-fields, redundant-return-value

local M = {}

function M.get_servers()
  local servers = {
    eslint = require('slivers.lang.typescript.lsp.eslint').config,
    tailwindcss = require('slivers.lang.typescript.lsp.tailwind').config,
    volar = require('slivers.lang.typescript.lsp.vue').config,
    vtsls = require('slivers.lang.typescript.lsp.typescript').config,
  }

  table.insert(servers.vtsls.settings.vtsls.tsserver.globalPlugins, require('slivers.lang.typescript.lsp.vue').plugin)

  return servers
end

return M
