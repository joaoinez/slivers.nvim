local M = {}

M.highlighters = {
  'javascript',
  'tsx',
  'typescript',
  'vue',
  'svelte',
}

M.formatters = {
  'prettierd',
}

M.formatters_by_ft = {
  javascript = { 'prettierd' },
  javascriptreact = { 'prettierd' },
  typescript = { 'prettierd' },
  typescriptreact = { 'prettierd' },
  vue = { 'prettierd' },
  css = { 'prettierd' },
}

M.debuggers = {
  'js-debug-adapter',
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
          Slivers.mason.get_pkg_path('js-debug-adapter', '/js-debug/src/dapDebugServer.js'),
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
          name = 'Launch file in new node process',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach debugger to existing `node --inspect` process',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
        -- TODO: test this
        {
          type = 'pwa-chrome',
          name = 'Launch Chrome to debug client',
          request = 'launch',
          url = 'http://localhost:5173',
          sourceMaps = true,
          protocol = 'inspector',
          port = 9222,
          webRoot = '${workspaceFolder}/src',
          -- skip files from vite's hmr
          skipFiles = { '**/node_modules/**/*', '**/@vite/*', '**/src/client/*', '**/src/*' },
        },
      }
    end
  end
end

return M
