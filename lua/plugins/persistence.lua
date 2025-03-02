---@type LazySpec
return {
  'folke/persistence.nvim',
  enabled = true,
  cond = not vim.g.vscode,
  event = 'BufReadPre',
  init = function()
    Slivers.autocmds.autocmd('User', {
      pattern = 'PersistenceSavePre',
      callback = function()
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
          -- NOTE: Use this to know the filetype
          --
          -- :lua vim.fn.system('echo "' .. vim.bo.filetype .. '" | pbcopy')
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
            DiffviewFiles = true,
          }

          if deletable_ft[vim.bo[bufnr].filetype] then vim.api.nvim_buf_delete(bufnr, { force = true }) end
        end

        vim.cmd 'delm A-Z'
      end,
    })
  end,
  opts = {},
}
