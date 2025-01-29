---@type LazySpec
return {
  'folke/persistence.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  event = 'BufReadPre',
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'PersistenceSavePre',
      callback = function()
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
          local deletable_ft = {
            [''] = true,
            oil = true,
            Avante = true,
            AvanteInput = true,
            AvanteSelectedFiles = true,
            Overseer = true,
            OverseerList = true,
            dapui_scopes = true,
            dapui_breakpoints = true,
            dapui_stacks = true,
            dapui_watches = true,
            ['dap-repl'] = true,
            dapui_console = true,
            ['dap-float'] = true,
            trouble = true,
            lazy = true,
            NeogitStatus = true,
            noice = true,
          }

          -- lua vim.fn.system('echo "' .. vim.bo.filetype .. '" | pbcopy')
          if deletable_ft[vim.bo[bufnr].filetype] then vim.api.nvim_buf_delete(bufnr, { force = true }) end
        end
      end,
    })
  end,
  opts = {},
}
