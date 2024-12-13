---@diagnostic disable: missing-fields, redundant-return-value

local M = {}

M.highlighters = {
  'css',
  'javascript',
  'tsx',
  'typescript',
  'vue',
}

M.servers = require('config.lang.typescript.lsp').get_servers()

M.formatters = {
  'prettierd',
}

M.formatters_by_ft = {
  javascript = { 'prettierd' },
  javascriptreact = { 'prettierd' },
  typescript = { 'prettierd' },
  typescriptreact = { 'prettierd' },
  vue = { 'prettierd' },
}

M.linters = {
  'eslint_d',
}

M.linters_by_ft = {
  javascript = { 'eslint_d' },
  javascriptreact = { 'eslint_d' },
  typescript = { 'eslint_d' },
  typescriptreact = { 'eslint_d' },
  vue = { 'eslint_d' },
}

M.debuggers = {
  'js',
}

---@param dap table
function M.dap_adapters(dap)
  if not dap.adapters['pwa-node'] then
    dap.adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'node',
        -- 💀 Make sure to update this path to point to your installation
        args = {
          SliverUtils.mason.get_pkg_path('js-debug-adapter', '/js-debug/src/dapDebugServer.js'),
          '${port}',
        },
      },
    }
  end

  if not dap.adapters['node'] then
    dap.adapters['node'] = function(cb, config)
      if config.type == 'node' then config.type = 'pwa-node' end
      local nativeAdapter = dap.adapters['pwa-node']
      if type(nativeAdapter) == 'function' then
        nativeAdapter(cb, config)
      else
        cb(nativeAdapter)
      end
    end
  end
end

M.dap_filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }

---@param dap table
function M.dap_configurations(dap)
  local vscode = require 'dap.ext.vscode'
  vscode.type_to_filetypes['node'] = M.dap_filetypes
  vscode.type_to_filetypes['pwa-node'] = M.dap_filetypes

  for _, language in ipairs(M.dap_filetypes) do
    if not dap.configurations[language] then
      dap.configurations[language] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
      }
    end
  end
end
return M
