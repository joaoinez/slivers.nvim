---@type LazySpec
return {
  'ibhagwan/fzf-lua',
  enabled = true,
  cmd = 'FzfLua',
  keys = {
    { '<c-j>', '<c-j>', ft = 'fzf', mode = 't', nowait = true },
    { '<c-k>', '<c-k>', ft = 'fzf', mode = 't', nowait = true },
    { '<leader>p', '<cmd>FzfLua<cr>', desc = 'Command Palette' },
    {
      '<leader><leader>',
      '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>',
      desc = 'Open Buffers',
    },
    { '<leader>:', '<cmd>FzfLua commands<cr>', desc = 'Commands' },
    { '<leader>ff', '<cmd>FzfLua files<cr>', desc = 'Find Files' },
    { '<leader>fg', '<cmd>FzfLua git_status<cr>', desc = 'Git Status' },
    { '<leader>fA', '<cmd>FzfLua autocmds<cr>', desc = 'Auto Commands' },
    { '<leader>f/', '<cmd>FzfLua grep_curbuf<cr>', desc = 'Search' },
    { '<leader>fc', '<cmd>FzfLua command_history<cr>', desc = 'Command History' },
    { '<leader>ft', '<cmd>FzfLua live_grep<cr>', desc = 'Find Text (project)' },
    { '<leader>fH', '<cmd>FzfLua help_tags<cr>', desc = 'Help Pages' },
    { '<leader>fj', '<cmd>FzfLua jumps<cr>', desc = 'Jumplist' },
    { '<leader>f?', '<cmd>FzfLua keymaps<cr>', desc = 'Keymaps' },
    { '<leader>fM', '<cmd>FzfLua man_pages<cr>', desc = 'Man Pages' },
    { '<leader>f.', '<cmd>FzfLua resume<cr>', desc = 'Resume Search' },
    { '<leader>fw', '<cmd>FzfLua grep_cword<cr>', desc = 'Find Word (project)' },
    { '<leader>fw', '<cmd>FzfLua grep_visual<cr>', mode = 'v', desc = 'Find Selection (project)' },
    { '<leader>,c', '<cmd>FzfLua colorschemes<cr>', desc = 'Colorscheme' },
  },
  ---@diagnostic disable-next-line: unused-local
  opts = function(_, opts)
    local config = require 'fzf-lua.config'
    local actions = require 'fzf-lua.actions'

    -- Previewer navigation
    config.defaults.keymap.fzf['ctrl-u'] = 'half-page-up'
    config.defaults.keymap.fzf['ctrl-d'] = 'half-page-down'
    config.defaults.keymap.fzf['ctrl-x'] = 'jump'
    config.defaults.keymap.fzf['ctrl-f'] = 'preview-page-down'
    config.defaults.keymap.fzf['ctrl-b'] = 'preview-page-up'
    config.defaults.keymap.builtin['<c-f>'] = 'preview-page-down'
    config.defaults.keymap.builtin['<c-b>'] = 'preview-page-up'

    -- Trouble
    if Slivers.lazy.is_available 'trouble.nvim' then
      config.defaults.actions.files['ctrl-q'] = require('trouble.sources.fzf').actions.open
    end

    -- Image previewer
    local img_previewer ---@type string[]?
    for _, v in ipairs {
      { cmd = 'chafa', args = { '{file}', '--format=symbols' } },
    } do
      if vim.fn.executable(v.cmd) == 1 then
        img_previewer = vim.list_extend({ v.cmd }, v.args)
        break
      end
    end

    return {
      'default-title',
      fzf_colors = true,
      fzf_opts = {
        ['--no-scrollbar'] = true,
      },
      defaults = {
        formatter = 'path.dirname_first',
      },
      previewers = {
        builtin = {
          extensions = {
            ['png'] = img_previewer,
            ['jpg'] = img_previewer,
            ['jpeg'] = img_previewer,
            ['gif'] = img_previewer,
            ['webp'] = img_previewer,
          },
        },
      },
      -- Custom LazyVim option to configure vim.ui.select
      ui_select = function(fzf_opts, items)
        return vim.tbl_deep_extend('force', fzf_opts, {
          prompt = ' ',
          winopts = {
            title = ' ' .. vim.trim((fzf_opts.prompt or 'Select'):gsub('%s*:%s*$', '')) .. ' ',
            title_pos = 'center',
          },
        }, fzf_opts.kind == 'codeaction' and {
          winopts = {
            layout = 'vertical',
            -- height is number of items minus 15 lines for the preview, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5) + 16,
            width = 0.5,
            preview = not vim.tbl_isempty(Slivers.lsp.get_clients { bufnr = 0, name = 'vtsls' }) and {
              layout = 'vertical',
              vertical = 'down:15,border-top',
              hidden = 'hidden',
            } or {
              layout = 'vertical',
              vertical = 'down:15,border-top',
            },
          },
        } or {
          winopts = {
            width = 0.5,
            -- height is number of items, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
          },
        })
      end,
      winopts = {
        width = 0.8,
        height = 0.8,
        row = 0.5,
        col = 0.5,
        preview = {
          scrollchars = { '┃', '' },
        },
      },
      files = {
        cwd_prompt = false,
        actions = {
          ['alt-h'] = { actions.toggle_hidden },
        },
      },
      grep = {
        actions = {
          ['alt-i'] = { actions.toggle_ignore },
          ['alt-h'] = { actions.toggle_hidden },
        },
      },
      lsp = {
        symbols = {
          symbol_hl = function(s) return 'TroubleIcon' .. s end,
          symbol_fmt = function(s) return s:lower() .. '\t' end,
          child_prefix = false,
        },
        code_actions = {
          previewer = vim.fn.executable 'delta' == 1 and 'codeaction_native' or nil,
        },
      },
    }
  end,
  config = function(_, opts)
    if opts[1] == 'default-title' then
      -- use the same prompt for all pickers for profile `default-title` and
      -- profiles that use `default-title` as base profile
      local function fix(t)
        t.prompt = t.prompt ~= nil and ' ' or nil
        for _, v in pairs(t) do
          if type(v) == 'table' then fix(v) end
        end
        return t
      end
      opts = vim.tbl_deep_extend('force', fix(require 'fzf-lua.profiles.default-title'), opts)
      opts[1] = nil
    end
    require('fzf-lua').setup(opts)
  end,
  init = function()
    Slivers.lazy.on_very_lazy(function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require('lazy').load { plugins = { 'fzf-lua' } }
        local opts = Slivers.lazy.opts 'fzf-lua' or {}
        require('fzf-lua').register_ui_select(opts.ui_select or nil)
        return vim.ui.select(...)
      end
    end)
  end,
}
