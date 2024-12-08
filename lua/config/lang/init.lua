local M = {}

function M.get_highlighters()
  local core = require 'config.lang.core'
  local lua = require 'config.lang.lua'

  local highlighters = {}

  vim.list_extend(highlighters, core.highlighters)
  vim.list_extend(highlighters, lua.highlighters)

  return highlighters
end

function M.get_servers()
  local lua = require 'config.lang.lua'

  local servers = {}

  vim.tbl_deep_extend('force', servers, lua.servers)

  return servers
end

function M.get_formatters()
  local core = require 'config.lang.core'
  local lua = require 'config.lang.lua'

  local formatters = {}

  vim.list_extend(formatters, lua.formatters)

  return formatters
end

function M.get_formatters_by_ft()
  local lua = require 'config.lang.lua'

  local formatters_by_ft = {}

  vim.list_extend(formatters_by_ft, lua.formatters_by_ft)

  return formatters_by_ft
end

function M.get_ft_with_disabled_formatters()
  local core = require 'config.lang.core'

  local ft_with_disabled_formatters = {}

  vim.list_extend(ft_with_disabled_formatters, core.ft_with_disabled_formatters)

  return ft_with_disabled_formatters
end

return M
