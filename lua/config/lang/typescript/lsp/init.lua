---@diagnostic disable: missing-fields, redundant-return-value

local M = {}

function M.get_servers()
  local servers = {
    eslint = require('config.lang.typescript.lsp.eslint').config,
    tailwindcss = require('config.lang.typescript.lsp.tailwind').config,
    volar = require('config.lang.typescript.lsp.vue').config,
    vtsls = require('config.lang.typescript.lsp.typescript').config,
  }

  table.insert(servers.vtsls.settings.vtsls.tsserver.globalPlugins, require('config.lang.typescript.lsp.vue').plugin)

  return servers
end

return M
