local M = {}

function M.get_highlighters()
  local core = require 'config.lang.core'
  local lua = require 'config.lang.lua'
  local typescript = require 'config.lang.typescript'

  local highlighters = {}

  vim.list_extend(highlighters, core.highlighters)
  vim.list_extend(highlighters, lua.highlighters)
  vim.list_extend(highlighters, typescript.highlighters)

  return highlighters
end

function M.get_servers()
  local lua = require 'config.lang.lua'
  local typescript = require 'config.lang.typescript'

  local servers = {}

  for server, opts in pairs(lua.servers) do
    servers[server] = opts
  end

  for server, opts in pairs(typescript.servers) do
    servers[server] = opts
  end

  return servers
end

function M.get_formatters()
  local lua = require 'config.lang.lua'
  local typescript = require 'config.lang.typescript'

  local formatters = {}

  vim.list_extend(formatters, lua.formatters)
  vim.list_extend(formatters, typescript.formatters)

  return formatters
end

function M.get_formatters_by_ft()
  local lua = require 'config.lang.lua'
  local typescript = require 'config.lang.typescript'

  local formatters_by_ft = {}

  for filetype, formatters in pairs(lua.formatters_by_ft) do
    formatters_by_ft[filetype] = formatters
  end

  for filetype, formatters in pairs(typescript.formatters_by_ft) do
    formatters_by_ft[filetype] = formatters
  end

  return formatters_by_ft
end

function M.get_ft_with_disabled_formatters()
  local core = require 'config.lang.core'

  local ft_with_disabled_formatters = {}

  vim.list_extend(ft_with_disabled_formatters, core.ft_with_disabled_formatters)

  return ft_with_disabled_formatters
end

return M
