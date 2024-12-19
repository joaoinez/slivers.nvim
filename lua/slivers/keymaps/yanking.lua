local map = Slivers.keymaps.safe_keymap_set

-- Copy entire file
map('n', '<leader>y', 'gg0yG', { desc = 'Yank File' })

-- Duplicate line
map('n', 'yd', '<cmd>norm yy<cr>p', { desc = 'Duplicate line' })

-- Duplicate line and comment the original
map('n', 'yc', '<cmd>norm yygcc<cr>p', { desc = 'Duplicate line and comment original' })

-- Duplicate text selection
map('x', '<M-J>', 'y`>p', { desc = 'Duplicate selection' })

-- -- Select recently pasted, yanked or changed text
map('n', 'gy', '`[v`]', { desc = 'Select recently pasted, yanked or changed text' })

-- Make 'c' key not copy to clipboard when changing a character.
map('n', 'c', '"_c', { desc = 'Change without yanking' })
map('n', 'C', '"_C', { desc = 'Change without yanking' })
map('x', 'c', '"_c', { desc = 'Change without yanking' })
map('x', 'C', '"_C', { desc = 'Change without yanking' })

-- Make 'x' key not copy to clipboard when deleting a character.
map(
  'n',
  'x',
  -- Also let's allow 'x' key to delete blank lines in normal mode.
  function()
    if vim.fn.col '.' == 1 then
      local line = vim.fn.getline '.'
      if line:match '^%s*$' then
        vim.api.nvim_feedkeys('"_dd', 'n', false)
        vim.api.nvim_feedkeys('$', 'n', false)
      else
        vim.api.nvim_feedkeys('"_x', 'n', false)
      end
    else
      vim.api.nvim_feedkeys('"_x', 'n', false)
    end
  end,
  { desc = 'Delete character without yanking it' }
)
map('x', 'x', '"_x', { desc = 'Delete all characters in line' })

-- Same for shifted X
map(
  'n',
  'X',
  -- Also let's allow 'x' key to delete blank lines in normal mode.
  function()
    if vim.fn.col '.' == 1 then
      local line = vim.fn.getline '.'
      if line:match '^%s*$' then
        vim.api.nvim_feedkeys('"_dd', 'n', false)
        vim.api.nvim_feedkeys('$', 'n', false)
      else
        vim.api.nvim_feedkeys('"_X', 'n', false)
      end
    else
      vim.api.nvim_feedkeys('"_X', 'n', false)
    end
  end,
  { desc = 'Delete before character without yanking it' }
)

-- Delete all characters in line
map('x', 'X', '"_X', { desc = 'Delete all characters in line' })

-- Override nvim default behavior so it doesn't auto-yank when pasting on visual mode.
map('x', 'p', 'P', { desc = "Paste content you've previourly yanked" })
map('x', 'P', 'p', { desc = 'Yank what you are going to override, then paste' })
