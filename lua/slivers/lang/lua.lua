local M = {}

M.highlighters = {
  'lua',
  'luadoc',
  'luap',
}

M.servers = {
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
  }
}

M.formatters = {
  'stylua',
}

M.formatters_by_ft = {
  lua = { 'stylua' },
}

return M
