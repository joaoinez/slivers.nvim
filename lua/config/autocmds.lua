local autocmd = Slivers.autocmds.autocmd
local augroup = Slivers.autocmds.augroup

-- Check if we need to reload the file when it is changed
autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup 'checktime',
  callback = function()
    if vim.o.buftype ~= 'nofile' then vim.cmd 'checktime' end
  end,
})

-- Highlight on yank
autocmd('TextYankPost', {
  group = augroup 'highlight_yank',
  callback = function() (vim.hl or vim.highlight).on_yank() end,
})

-- Resize splits if window got resized
autocmd({ 'VimResized' }, {
  group = augroup 'resize_splits',
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd 'tabdo wincmd ='
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- Close some filetypes with <q>
autocmd('FileType', {
  group = augroup 'close_with_q',
  pattern = {
    'PlenaryTestPopup',
    'checkhealth',
    'dbout',
    'gitsigns-blame',
    'grug-far',
    'help',
    'lspinfo',
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

-- Effect: URL underline.
vim.api.nvim_set_hl(0, 'HighlightURL', { underline = true })
autocmd({ 'VimEnter', 'FileType', 'BufEnter', 'WinEnter' }, {
  desc = 'URL Highlighting',
  callback = function() Slivers.misc.set_url_effect() end,
})

-- Create parent directories when saving a file.
autocmd('BufWritePre', {
  desc = "Automatically create parent directories if they don't exist when saving a file",
  callback = function(args)
    local buf_is_valid_and_listed = vim.api.nvim_buf_is_valid(args.buf) and vim.bo[args.buf].buflisted

    if buf_is_valid_and_listed then
      vim.fn.mkdir(vim.fn.fnamemodify(vim.uv.fs_realpath(args.match) or args.match, ':p:h'), 'p')
    end
  end,
})

--    This is pretty much the same thing as the event 'BufEnter',
--    but without increasing the startup time displayed in the greeter.
autocmd({ 'BufReadPost', 'BufNewFile', 'BufWritePost' }, {
  desc = 'Nvim user event for file detection (LazyFile)',
  callback = function(args)
    local empty_buffer = vim.fn.resolve(vim.fn.expand '%') == ''
    local greeter = vim.api.nvim_get_option_value('filetype', { buf = args.buf }) == 'snacks_dashboard'

    -- For any file exept empty buffer, or the greeter (snacks dashboard)
    if not (empty_buffer or greeter) then Slivers.actions.trigger_event 'User LazyFile' end
  end,
})
