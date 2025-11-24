local M = {}

M.langs = {
  require 'slivers.lang.core',
  require 'slivers.lang.bash',
  require 'slivers.lang.csharp',
  require 'slivers.lang.css',
  require 'slivers.lang.eslint',
  require 'slivers.lang.go',
  require 'slivers.lang.godot',
  require 'slivers.lang.json',
  require 'slivers.lang.lua',
  require 'slivers.lang.markdown',
  require 'slivers.lang.python',
  require 'slivers.lang.typescript',
  require 'slivers.lang.yaml',
}

function M.get_highlighters()
  local highlighters = {}

  for _, lang in ipairs(M.langs) do
    vim.list_extend(highlighters, lang.highlighters or {})
  end

  return highlighters
end

function M.get_lsp_configs()
  local lsp_configs = {}

  for _, lang in ipairs(M.langs) do
    if lang.lsp then table.insert(lsp_configs, lang.lsp) end
  end

  return lsp_configs
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

function M.get_debuggers()
  local debuggers = {}

  for _, lang in ipairs(M.langs) do
    vim.list_extend(debuggers, lang.debuggers or {})
  end

  return debuggers
end

---@param dap table
function M.setup_dap_adapters(dap)
  for _, lang in ipairs(M.langs) do
    local adapters = lang.dap_adapters or {}

    if type(adapters) == 'function' then
      adapters(dap)
    else
      for adapter, config in pairs(adapters) do
        dap.adapters[adapter] = config
      end
    end
  end
end

---@param dap table
function M.setup_dap_configurations(dap)
  for _, lang in ipairs(M.langs) do
    local configurations = lang.dap_configurations or {}

    if type(configurations) == 'function' then
      configurations(dap)
    else
      for _, filetype in ipairs(lang.dap_filetypes or {}) do
        dap.configurations[filetype] = configurations
      end
    end
  end
end

return M
