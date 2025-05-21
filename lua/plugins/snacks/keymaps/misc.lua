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
  {
    '<leader>,c',
    function()
      Snacks.picker {
        finder = function()
          local colorschemes = Slivers.colorscheme.get_installed_colorschemes()
          return vim.tbl_map(function(color) return { text = color, value = color } end, colorschemes)
        end,
        on_change = function(_, item)
          if not item then return end

          vim.cmd('colorscheme ' .. item.value)
          ColorSliver()
        end,
        format = 'text',
        title = 'Colorschemes',
        layout = { preset = 'vscode' },
        confirm = function(picker, item)
          picker:close()
          vim.schedule(function()
            local path = vim.fn.stdpath 'config' .. '/.slivers.json'

            if Slivers.misc.file_exists(path) then
              local config = vim.json.decode(Slivers.misc.read_file(path))

              config.colorscheme = item.value

              Slivers.misc.write_file(path, vim.json.encode(config))
            end

            vim.cmd('colorscheme ' .. item.value)

            ColorSliver()

            vim.cmd 'cq'
          end)
        end,
      }
    end,
    desc = 'Colorschemes',
  },
  {
    '<leader>,a',
    function()
      Snacks.picker {
        finder = function()
          local models = vim.tbl_keys(require 'slivers.ai_models')
          return vim.tbl_map(function(color) return { text = color, value = color } end, vim.fn.sort(models))
        end,
        format = 'text',
        title = 'AI Models',
        layout = { preset = 'vscode' },
        confirm = function(picker, item)
          picker:close()
          vim.schedule(function()
            local path = vim.fn.stdpath 'config' .. '/.slivers.json'

            if Slivers.misc.file_exists(path) then
              local config = vim.json.decode(Slivers.misc.read_file(path))

              config.ai_model = item.value

              Slivers.misc.write_file(path, vim.json.encode(config))
            end

            vim.cmd 'cq'
          end)
        end,
      }
    end,
    desc = 'AI Models',
  },
  { '<leader>tz', function() Snacks.zen() end, desc = 'Zen Mode' },
  { '<leader>.', function() Snacks.scratch() end, desc = 'Scratch Buffer' },
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
