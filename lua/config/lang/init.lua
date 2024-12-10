local M = {}

M.langs = {
  require 'config.lang.core',
  require 'config.lang.lua',
  require 'config.lang.typescript',
}

function M.get_highlighters()
  local highlighters = {}

  for _, lang in ipairs(M.langs) do
    vim.list_extend(highlighters, lang.highlighters or {})
  end

  return highlighters
end

function M.get_servers()
  local servers = {}

  for _, lang in ipairs(M.langs) do
    for server, opts in pairs(lang.servers or {}) do
      servers[server] = opts
    end
  end

  return servers
end

function M.get_formatters()
  local formatters = {}

  for _, lang in ipairs(M.langs) do
    vim.list_extend(formatters, lang.formatters or {})
  end

  return formatters
end

function M.get_formatters_by_ft()
  local formatters_by_ft = {}

  for _, lang in ipairs(M.langs) do
    for filetype, formatters in pairs(lang.formatters_by_ft or {}) do
      formatters_by_ft[filetype] = formatters
    end
  end

  return formatters_by_ft
end

function M.get_ft_with_disabled_formatters()
  local ft_with_disabled_formatters = {}

  for _, lang in ipairs(M.langs) do
    vim.list_extend(ft_with_disabled_formatters, lang.ft_with_disabled_formatters or {})
  end

  return ft_with_disabled_formatters
end

function M.get_linters()
  local linters = {}

  for _, lang in ipairs(M.langs) do
    vim.list_extend(linters, lang.linters or {})
  end

  return linters
end

function M.get_linters_by_ft()
  local linters_by_ft = {}

  for _, lang in ipairs(M.langs) do
    for filetype, linters in pairs(lang.linters_by_ft or {}) do
      linters_by_ft[filetype] = linters
    end
  end

  return linters_by_ft
end

return M
