local M = {}

--- @param client vim.lsp.Client|nil The client where the lsp mappings will load.
--- @param bufnr integer The bufnr where the lsp mappings will load.
function M.apply_user_lsp_mappings(client, bufnr)
  local builtin = require 'telescope.builtin'
  local utils = require 'utils'
  local supports = utils.supports(client)
  local maps = utils.get_mappings_template()

  maps.n['gd'] = {
    function() builtin.lsp_definitions() end,
    desc = 'Goto Definition',
  }
  maps.n['gr'] = {
    function() builtin.lsp_references() end,
    desc = 'Goto References',
  }
  maps.n['gI'] = {
    function() builtin.lsp_implementations() end,
    desc = 'Goto Implementation',
  }
  maps.n['<leader>D'] = {
    function() builtin.lsp_type_definitions() end,
    desc = 'Type Definition',
  }
  maps.n['<leader>ds'] = {
    function() builtin.lsp_document_symbols() end,
    desc = 'Document Symbols',
  }
  maps.n['<leader>ws'] = {
    function() builtin.lsp_dynamic_workspace_symbols() end,
    desc = 'Workspace Symbols',
  }
  maps.n['gD'] = {
    vim.lsp.buf.declaration,
    desc = 'Goto Declaration',
  }
  maps.n['<leader>rn'] = {
    vim.lsp.buf.rename,
    desc = 'Rename',
  }
  maps.n['<leader>ca'] = {
    vim.lsp.buf.code_action,
    desc = 'Code Action',
  }
  maps.x['<leader>ca'] = {
    vim.lsp.buf.code_action,
    desc = 'Code Action',
  }

  if supports 'textDocument_documentHighlight' then
    maps.n['<leader>th'] = {
      function()
        vim.lsp.inlay_hint.enable(
          not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }
        )
      end,
      desc = 'Toggle Inlay Hints',
    }
  end

  utils.set_mappings(maps)
end

return M
