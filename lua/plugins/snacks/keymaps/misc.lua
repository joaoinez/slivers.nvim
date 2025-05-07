local M = {
  { '<leader>kD', function() Snacks.terminal 'lazydocker' end, desc = 'Lazydocker' },
  {
    '<leader>,n',
    desc = 'Neovim News',
    function()
      Snacks.win {
        file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
        width = 84,
        height = 0.6,
        border = 'rounded',
        wo = {
          spell = false,
          wrap = false,
          signcolumn = 'yes',
          statuscolumn = ' ',
          conceallevel = 3,
        },
      }
    end,
  },
  {
    '<leader>tp',
    function()
      local bufnr = vim.api.nvim_get_current_buf()
      Snacks.picker {
        finder = function()
          local parsers = require('nvim-treesitter.parsers').available_parsers()
          return vim.tbl_map(function(lang) return { text = lang, value = lang } end, parsers)
        end,
        format = 'text',
        title = 'Treesitter Parsers',
        layout = { preset = 'vscode' },
        confirm = function(picker, item)
          picker:close()
          vim.schedule(function()
            local has_parser = require('nvim-treesitter.parsers').has_parser(item.value)
            if has_parser then
              vim.bo[bufnr].filetype = item.value
              vim.treesitter.start(bufnr, item.value)
            end
          end)
        end,
      }
    end,
    desc = 'Treesitter Parser',
  },
  { '<leader>tz', function() Snacks.zen() end, desc = 'Zen Mode' },
  { '<leader>.', function() Snacks.scratch() end, desc = 'Scratch Buffer' },
  { '<leader>v', function() Snacks.picker.cliphist() end, desc = 'Clipboard' },
  {
    ']]',
    function() Snacks.words.jump(vim.v.count1) end,
    desc = 'Next Reference (snacks)',
  },
  {
    '[[',
    function() Snacks.words.jump(-vim.v.count1) end,
    desc = 'Previous Reference (snacks)',
  },
}

return M
