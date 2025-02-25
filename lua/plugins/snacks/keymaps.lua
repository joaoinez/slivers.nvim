---@diagnostic disable: missing-fields

local M = {
  -- [[ Pickers ]]
  -- File related
  {
    '<leader><space>',
    function()
      Snacks.picker.buffers {
        layout = {
          preset = 'ivy',
          preview = 'main',
        },
        hidden = true,
        unloaded = false,
        nofile = false,
        win = {
          input = {
            footer = '┤ <c-w> close │ <a-s> flash ├ ',
            footer_pos = 'left',
            keys = {
              ['<c-w>'] = { 'bufdelete', mode = { 'n', 'i' } },
            },
          },
        },
      }
    end,
    desc = 'Open Buffers',
  },
  {
    '<leader>ff',
    function()
      Snacks.picker.smart {
        multi = { 'buffers', 'files' },
        hidden = true,
        win = { input = { footer = '┤ <a-h> hidden │ <a-i> ignored │ <a-s> flash ├ ', footer_pos = 'right' } },
      }
    end,
    desc = 'Find Files',
  },
  {
    '<leader>fd',
    function()
      local current_dir = vim.fn.expand '%:p:h'
      if current_dir == '' or vim.fn.isdirectory(current_dir) == 0 then current_dir = vim.fn.getcwd() end
      Snacks.picker.files {
        cwd = current_dir,
        win = {
          input = {
            footer = '┤ <a-h> hidden │ <a-i> ignored │ <a-s> flash ├ ',
            footer_pos = 'right',
          },
        },
      }
    end,
    desc = 'Find Files (cwd)',
  },
  {
    '<leader>ft',
    function()
      Snacks.picker.grep {
        layout = 'bottom',
        win = {
          input = {
            footer = '┤ <a-h> hidden │ <a-i> ignored │ <a-s> flash ├ ',
            footer_pos = 'left',
          },
        },
      }
    end,
    desc = 'Find Text',
  },
  {
    '<leader>fw',
    function()
      Snacks.picker.grep_word {
        layout = 'bottom',
        win = {
          input = {
            footer = '┤ <a-h> hidden │ <a-i> ignored │ <a-s> flash ├ ',
            footer_pos = 'left',
          },
        },
      }
    end,
    desc = 'Find Word',
  },
  {
    '<leader>fw',
    function()
      Snacks.picker.grep_word {
        layout = 'bottom',
        win = {
          input = {
            footer = '┤ <a-h> hidden │ <a-i> ignored │ <a-s> flash ├ ',
            footer_pos = 'left',
          },
        },
      }
    end,
    desc = 'Find Selection',
    mode = 'x',
  },
  {
    '<leader>fm',
    function()
      Snacks.picker.marks {
        layout = {
          preset = 'ivy',
          preview = 'main',
        },
        global = true,
        ['local'] = true,
        ---@type snacks.picker.transform
        transform = function(item)
          if item.text:match '^[0-9\'"%[%]^<>`.]' then return false end
          return item
        end,
        win = { input = { footer = '┤ <a-s> flash ├ ', footer_pos = 'left' } },
      }
    end,
    desc = 'Find Marks',
  },
  { '<leader>f/', function() Snacks.picker.lines() end, desc = 'Search' },
  {
    '<leader>fy',
    function() Snacks.terminal('yazi', { win = { border = 'rounded' } }) end,
    desc = 'File Explorer (yazi)',
  },

  -- Others
  { '<leader>f.', function() Snacks.picker.resume() end, desc = 'Resume' },
  {
    '<leader>kp',
    function() Snacks.picker { title = 'Command Palette', layout = 'vscode' } end,
    desc = 'Command Palette',
  },
  { '<leader>fh', function() Snacks.picker.help { layout = 'vscode' } end, desc = 'Find Help' },
  { '<leader>fp', function() Snacks.picker.projects { layout = 'vscode' } end, desc = 'Projects' },
  { '<leader>:', function() Snacks.picker.commands { layout = 'vscode' } end, desc = 'Commands' },
  { '<leader>fc', function() Snacks.picker.command_history() end, desc = 'Command History' },
  {
    '<leader>fj',
    function() Snacks.picker.jumps { layout = { preset = 'ivy', preview = 'main' } } end,
    desc = 'Jump History',
  },
  { '<leader>fu', function() Snacks.picker.undo { layout = 'dropdown' } end, desc = 'Undo History' },
  {
    '<leader>f?',
    function() Snacks.picker.keymaps { layout = 'top' } end,
    desc = 'Keymaps',
  },
  { '<leader>fM', function() Snacks.picker.man() end, desc = 'Man Pages' },
  { '<leader>fA', function() Snacks.picker.autocmds() end, desc = 'Auto Commands' },
  {
    '<leader>f,',
    function()
      Snacks.picker.files {
        ---@diagnostic disable-next-line: assign-type-mismatch
        cwd = vim.fn.stdpath 'config',
        win = {
          input = {
            footer = '┤ <a-h> hidden │ <a-i> ignored │ <a-s> flash ├ ',
            footer_pos = 'right',
          },
        },
      }
    end,
    desc = 'Neovim Config',
  },

  -- [[ Git ]]
  {
    '<leader>gb',
    function()
      Snacks.picker.git_branches {
        layout = 'vscode',
        win = { input = { footer = '┤ <c-a> add │ <c-x> delete ├ ', footer_pos = 'center' } },
      }
    end,
    desc = 'Git Branches',
  },
  {
    '<leader>gs',
    function()
      Snacks.picker.git_status {
        win = {
          input = {
            footer = '┤ <tab> (un)stage │ <c-g> git │ <c-c> commit ├ ',
            footer_pos = 'right',
            keys = {
              ['<c-g>'] = {
                'neogit_open',
                mode = { 'n', 'i' },
              },
              ['<c-c>'] = {
                'neogit_commit',
                mode = { 'n', 'i' },
              },
            },
          },
        },
        actions = {
          neogit_open = function() require('neogit').open() end,
          neogit_commit = function(picker)
            require('neogit').open { 'commit' }
            picker:close()
          end,
        },
      }
    end,
    desc = 'Git Status',
  },
  {
    '<leader>gl',
    function() Snacks.picker.git_log_file() end,
    desc = 'Log (file)',
  },
  {
    '<leader>g/',
    function() Snacks.terminal('git hook run pre-commit', { auto_close = false, win = { border = 'rounded' } }) end,
    desc = 'Run `pre-commit` hook',
  },
  {
    '<leader>gC',
    function()
      local command = [[
bash -c '
aider --commit || exit 1
while true; do
  read -n 1 -s -p "Press \"q\" to quit or \"P\" to push: " key
  printf "\n"
  case "$key" in
    q) echo "Quitting without pushing"; exit 0;;
    P) git push
       while true; do
         read -n 1 -s -p "Push completed. Press \"q\" to quit: " key
         printf "\n"
         [ "$key" = "q" ] && exit 0
       done
       ;;
    *) echo "Invalid option";;
  esac
done
']]

      vim.cmd 'w'
      Snacks.terminal(command, { win = { border = 'rounded' } })
    end,
    desc = 'Commit (aider)',
  },
  { '<leader>gG', function() Snacks.lazygit() end, desc = 'Lazygit' },
  { '<leader>gB', function() Snacks.gitbrowse() end, desc = 'Browse Repo (github)' },
  {
    '<leader>go',
    function() Snacks.terminal('gh pr create', { win = { border = 'rounded' } }) end,
    desc = 'Open PR (github)',
  },

  -- [[ Terminal ]]
  {
    '<leader>tt',
    function()
      local git_root = Snacks.git.get_root()
      Snacks.terminal(nil, { cwd = git_root })
    end,
    desc = 'Terminal',
  },
  {
    '<leader>tC',
    function()
      local current_dir = vim.fn.expand '%:p:h'
      if current_dir == '' or vim.fn.isdirectory(current_dir) == 0 then current_dir = vim.fn.getcwd() end
      Snacks.terminal(nil, { cwd = current_dir })
    end,
    desc = 'Terminal (cwd)',
  },

  -- [[ Misc ]]
  { '<leader>kD', function() Snacks.terminal 'lazydocker' end, desc = 'Lazydocker' },
  { '<leader>v', function() Snacks.picker.cliphist() end, desc = 'Clipboard' },
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
