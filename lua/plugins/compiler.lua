-- INFO: To Build and run a godot scene, use the command godot /my/scene.tscn on the terminal.
-- This works really well: It's fast and simple.

return {
  {
    'Zeioth/compiler.nvim',
    dependencies = { 'stevearc/overseer.nvim' },
    cmd = { 'CompilerOpen', 'CompilerToggleResults', 'CompilerRedo' },
    keys = {
      { '<leader>r', '<cmd>CompilerOpen<cr>', desc = 'Run Code' },
      { '<leader>R', '<cmd>CompilerStop<cr>' .. '<cmd>CompilerRedo<cr>', desc = 'Rerun Code' },
      { '<leader>tc', '<cmd>CompilerToggleResults<cr>', desc = 'Compiler' },
    },
    opts = {},
  },
  {
    'stevearc/overseer.nvim',
    cmd = { 'CompilerOpen', 'CompilerToggleResults', 'CompilerRedo' },
    opts = {
      task_list = {
        direction = 'bottom',
        min_height = 25,
        max_height = 25,
        default_detail = 1,
      },
    },
  },
}
