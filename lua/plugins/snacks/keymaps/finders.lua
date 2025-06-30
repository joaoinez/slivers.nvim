local M = {
  {
    '<leader>kp',
    function() Snacks.picker { title = 'Command Palette', layout = 'vscode' } end,
    desc = 'Command Palette',
  },
  { '<leader>f.', function() Snacks.picker.resume() end, desc = 'Resume' },
  { '<leader>fh', function() Snacks.picker.help { layout = 'vscode' } end, desc = 'Find Help' },
  { '<leader>fp', function() Snacks.picker.projects { layout = 'vscode' } end, desc = 'Projects' },
  { '<leader>:', function() Snacks.picker.commands { layout = 'vscode' } end, desc = 'Commands' },
  { '<leader>fc', function() Snacks.picker.command_history() end, desc = 'Command History' },
  {
    '<leader>fj',
    function() Snacks.picker.jumps { layout = { preset = 'bottom', preview = 'main' } } end,
    desc = 'Jump History',
  },
  { '<leader>u', function() Snacks.picker.undo { layout = 'dropdown' } end, desc = 'Undo History' },
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
          preview = {
            footer = '┤ <a-h> hidden │ <a-i> ignored │ <a-s> flash ├ ',
            footer_pos = 'right',
          },
        },
      }
    end,
    desc = 'Neovim Config',
  },
}

return M
