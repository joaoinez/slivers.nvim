local autocmd = Slivers.autocmds.autocmd
local augroup = Slivers.autocmds.augroup

-- [[ Auto Commands ]]

-- Highlight on yank
autocmd('TextYankPost', {
  desc = 'Highlight on yank',
  group = augroup 'highlight_yank',
  callback = function() (vim.hl or vim.highlight).on_yank() end,
})

if not vim.g.vscode then
  -- Check if we need to reload the file when it is changed
  autocmd({ 'FocusGained', 'TermClose', 'TermLeave', 'TabEnter' }, {
    desc = 'Check if we need to reload the file when it is changed',
    group = augroup 'checktime',
    callback = function()
      if vim.o.buftype ~= 'nofile' then vim.cmd 'set autoread | checktime' end
    end,
  })

  -- Resize splits if window got resized
  autocmd({ 'VimResized' }, {
    desc = 'Resize splits if window got resized',
    group = augroup 'resize_splits',
    callback = function()
      local current_tab = vim.fn.tabpagenr()
      vim.cmd 'tabdo wincmd ='
      vim.cmd('tabnext ' .. current_tab)
    end,
  })

  -- Close some filetypes with <q>
  autocmd('FileType', {
    desc = 'Close filetypes with <q>',
    group = augroup 'close_with_q',
    pattern = {
      'PlenaryTestPopup',
      'checkhealth',
      'dbout',
      'gitsigns-blame',
      'grug-far',
      'help',
      'lspinfo',
      'man',
      'neotest-output',
      'neotest-output-panel',
      'neotest-summary',
      'notify',
      'qf',
      'snacks_win',
      'spectre_panel',
      'startuptime',
      'tsplayground',
      'query', -- InspectTree
      'dap-float', -- DAP floating widgets
      'neotest-output-panel',
      'neotest-summary',
      'lazy',
    },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.schedule(function()
        vim.keymap.set('n', 'q', function()
          vim.cmd 'close'
          pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
        end, {
          buffer = event.buf,
          silent = true,
          desc = 'Quit buffer',
        })
      end)
    end,
  })

  -- Close slivers options window with q and exit code 1
  autocmd('BufEnter', {
    desc = 'Close slivers options window with q and exit code 1',
    group = augroup 'close_options_with_q',
    callback = function(event)
      vim.schedule(function()
        local is_slivers_options = pcall(function() return vim.api.nvim_buf_get_var(event.buf, 'slivers_options') end)

        if is_slivers_options then
          vim.bo[event.buf].buflisted = false
          vim.keymap.set('n', 'q', function()
            if vim.bo[event.buf].modified then
              vim.cmd 'w'
              vim.cmd 'cq'
            else
              vim.cmd 'close'
            end
            pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
          end, {
            buffer = event.buf,
            silent = true,
            desc = 'Quit buffer',
          })
        end
      end)
    end,
  })

  -- Effect: URL underline.
  vim.api.nvim_set_hl(0, 'HighlightURL', { underline = true })
  autocmd({ 'VimEnter', 'FileType', 'BufEnter', 'WinEnter' }, {
    desc = 'URL Highlighting',
    callback = function() Slivers.misc.set_url_effect() end,
  })

  -- Create parent directories when saving a file
  autocmd('BufWritePre', {
    desc = "Automatically create parent directories if they don't exist when saving a file",
    callback = function(args)
      local buf_is_valid_and_listed = vim.api.nvim_buf_is_valid(args.buf) and vim.bo[args.buf].buflisted

      if buf_is_valid_and_listed then
        vim.fn.mkdir(vim.fn.fnamemodify(vim.uv.fs_realpath(args.match) or args.match, ':p:h'), 'p')
      end
    end,
  })

  -- Automatically enter terminal buff
  autocmd('BufEnter', {
    desc = 'Automatically enter terminal buffer',
    group = augroup 'term_focus',
    callback = function()
      if vim.bo.buftype == 'terminal' then vim.cmd 'norm i' end
    end,
  })

  -- Show cursorline only on active windows
  autocmd({ 'InsertLeave', 'WinEnter' }, {
    desc = 'Show cursorline only on active windows',
    callback = function()
      if vim.w.auto_cursorline then
        vim.wo.cursorline = true
        vim.w.auto_cursorline = false
      end
    end,
  })
  autocmd({ 'InsertEnter', 'WinLeave' }, {
    desc = 'Hide cursorline on inactive windows',
    callback = function()
      if vim.wo.cursorline then
        vim.w.auto_cursorline = true
        vim.wo.cursorline = false
      end
    end,
  })

  -- Show help buffer split at the top
  autocmd('FileType', {
    desc = 'Automatically Split help Buffers to the top',
    pattern = 'help',
    command = 'wincmd K',
  })

  -- Corrects terminal background color according to colorscheme
  autocmd({ 'UIEnter', 'ColorScheme' }, {
    desc = 'Corrects terminal background color according to colorscheme, see: https://www.reddit.com/r/neovim/comments/1ehidxy/you_can_remove_padding_around_neovim_instance/',
    callback = function()
      if vim.api.nvim_get_hl(0, { name = 'Normal' }).bg then
        io.write(string.format('\027]11;#%06x\027\\', vim.api.nvim_get_hl(0, { name = 'Normal' }).bg))
      end
      autocmd('UILeave', {
        callback = function() io.write '\027]111\027\\' end,
      })
    end,
  })
end

-- Set `sh` filetype for .env files
autocmd({ 'BufNewFile', 'BufReadPost' }, {
  desc = 'Set sh filetype for .env files',
  pattern = '.env*',
  callback = function() vim.bo.filetype = 'sh' end,
})

--[[ -- HACK: This shouldn't be necessary, but Rzls doesn't load the Razor syntax properly.
--
-- Refresh Razor syntax highlighting
autocmd('BufEnter', {
  desc = 'Refresh Razor syntax highlighting on buffer enter',
  pattern = { '*.razor', '*.cs' },
  callback = function(args)
    -- Check that we're entering a normal file buffer (not a popup or special buffer)
    if vim.bo[args.buf].buftype ~= '' then return end

    -- Skip if already refreshing to prevent duplicate runs
    if vim.b[args.buf].razor_is_refreshing then return end

    -- Check if this is the initial load (razor_initial_refresh not set yet)
    if vim.b[args.buf].razor_initial_refresh == nil and vim.bo[args.buf].filetype == 'razor' then
      -- First time opening this buffer - wait 5 seconds before refresh
      vim.b[args.buf].razor_initial_refresh = false
      vim.b[args.buf].razor_is_refreshing = true

      -- Make buffer non-editable during initial load
      vim.bo[args.buf].modifiable = false

      vim.defer_fn(function()
        if vim.api.nvim_buf_is_valid(args.buf) then
          vim.cmd 'e!'
          vim.b[args.buf].razor_initial_refresh = true
          vim.b[args.buf].razor_syntax_refreshed = true
          vim.b[args.buf].razor_is_refreshing = false
          -- Re-enable editing after refresh
          vim.bo[args.buf].modifiable = true
        end
      end, 5000)

      return
    end

    -- Skip if already refreshed (for subsequent re-entries)
    if vim.b[args.buf].razor_syntax_refreshed then
      vim.bo[args.buf].modifiable = true
      return
    end

    -- Mark as refreshing to prevent concurrent runs
    vim.b[args.buf].razor_is_refreshing = true

    -- Double-check the buffer is still valid and we're still in it
    if vim.api.nvim_buf_is_valid(args.buf) and vim.api.nvim_get_current_buf() == args.buf then
      vim.cmd 'e!'
      vim.b[args.buf].razor_syntax_refreshed = true
      vim.b[args.buf].razor_is_refreshing = false
      vim.bo[args.buf].modifiable = true
    else
      vim.b[args.buf].razor_is_refreshing = false
    end
  end,
})
autocmd('BufLeave', {
  desc = 'Reset Razor syntax refresh flag when leaving',
  pattern = { '*.razor', '*.cs' },
  callback = function(args)
    -- Defer checking to ensure we can accurately detect the target buffer
    if not vim.api.nvim_buf_is_valid(args.buf) then return end

    -- Get the current buffer we switched to
    local current_buf = vim.api.nvim_get_current_buf()

    -- Only reset if we switched to a normal file buffer (not a popup/floating/special buffer)
    -- This prevents resetting when opening mini.files, which uses buftype 'nofile'
    if vim.bo[current_buf].buftype == '' then vim.b[args.buf].razor_syntax_refreshed = false end
  end,
}) ]]
