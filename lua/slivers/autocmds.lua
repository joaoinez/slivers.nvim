---@diagnostic disable: missing-fields

local autocmd = Slivers.autocmds.autocmd
local augroup = Slivers.autocmds.augroup
local cmd = vim.api.nvim_create_user_command

-- [[ Auto Commands ]]

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
    'dap-float', -- DAP floating widgets
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

autocmd('BufEnter', {
  group = augroup 'term_focus',
  callback = function()
    if vim.bo.buftype == 'terminal' then vim.cmd 'norm i' end
  end,
})

-- [[ User Commands ]]

-- Update Everything
cmd('UpdateEverything', function()
  vim.cmd ':Lazy update'
  vim.cmd ':TSUpdate'
  vim.cmd ':MasonToolsUpdate'
end, { desc = 'Update lazy, treesitter and mason' })

-- -- Lua function to dump colorschemes to the clipboard
-- vim.api.nvim_create_user_command('DumpColorschemesToClipboard', function()
--   -- Get a list of all colorschemes
--   local schemes = vim.fn.split(vim.fn.globpath(vim.o.runtimepath, 'colors/*.vim'), '\n')
--   schemes = vim.fn.map(schemes, function(_, val) return vim.fn.fnamemodify(val, ':t:r') end)
--   local clipboard_contents = table.concat(schemes, '\n')
--
--   -- Use system clipboard utility (adjust for your system)
--   if vim.fn.has 'mac' == 1 then
--     vim.fn.system('echo "' .. clipboard_contents .. '" | pbcopy') -- macOS
--   elseif vim.fn.has 'unix' == 1 then
--     if vim.fn.executable 'xclip' == 1 then
--       vim.fn.system('echo "' .. clipboard_contents .. '" | xclip -selection clipboard') -- Linux
--     elseif vim.fn.executable 'wl-copy' == 1 then
--       vim.fn.system('echo "' .. clipboard_contents .. '" | wl-copy') -- Wayland
--     else
--       print 'No suitable clipboard utility found (xclip/wl-copy).'
--     end
--   end
--
--   print 'Colorschemes copied to clipboard.'
-- end, { desc = 'Dump all available colorschemes to the clipboard' })
