local map = Slivers.keymaps.safe_keymap_set

-- Disable arrow keys in normal mode
map('n', '<left>', '<nop>')
map('n', '<down>', '<nop>')
map('n', '<up>', '<nop>')
map('n', '<right>', '<nop>')

-- Disable `s` key for flash and surround plugins
map({ 'n', 'x' }, 's', '<nop>')

-- Disable `m` for match operations
map('n', 'm', '<nop>')

-- Hide m[a-zA-Z] combinations from which-key
Slivers.lazy.on_load('which-key.nvim', function()
  vim.schedule(
    function()
      require('which-key').add {
        { 'ma', hidden = true, mode = { 'n', 'x' } },
        { 'mb', hidden = true, mode = { 'n', 'x' } },
        { 'mc', hidden = true, mode = { 'n', 'x' } },
        { 'me', hidden = true, mode = { 'n', 'x' } },
        { 'mg', hidden = true, mode = { 'n', 'x' } },
        { 'mi', hidden = true, mode = { 'n', 'x' } },
        { 'mj', hidden = true, mode = { 'n', 'x' } },
        { 'mk', hidden = true, mode = { 'n', 'x' } },
        { 'ml', hidden = true, mode = { 'n', 'x' } },
        { 'mm', hidden = true, mode = { 'n', 'x' } },
        { 'mo', hidden = true, mode = { 'n', 'x' } },
        { 'mp', hidden = true, mode = { 'n', 'x' } },
        { 'mq', hidden = true, mode = { 'n', 'x' } },
        { 'mu', hidden = true, mode = { 'n', 'x' } },
        { 'mv', hidden = true, mode = { 'n', 'x' } },
        { 'mw', hidden = true, mode = { 'n', 'x' } },
        { 'mx', hidden = true, mode = { 'n', 'x' } },
        { 'my', hidden = true, mode = { 'n', 'x' } },
        { 'mz', hidden = true, mode = { 'n', 'x' } },
        { 'mA', hidden = true, mode = { 'n', 'x' } },
        { 'mB', hidden = true, mode = { 'n', 'x' } },
        { 'mC', hidden = true, mode = { 'n', 'x' } },
        { 'mD', hidden = true, mode = { 'n', 'x' } },
        { 'mE', hidden = true, mode = { 'n', 'x' } },
        { 'mG', hidden = true, mode = { 'n', 'x' } },
        { 'mH', hidden = true, mode = { 'n', 'x' } },
        { 'mI', hidden = true, mode = { 'n', 'x' } },
        { 'mJ', hidden = true, mode = { 'n', 'x' } },
        { 'mK', hidden = true, mode = { 'n', 'x' } },
        { 'mL', hidden = true, mode = { 'n', 'x' } },
        { 'mM', hidden = true, mode = { 'n', 'x' } },
        { 'mN', hidden = true, mode = { 'n', 'x' } },
        { 'mO', hidden = true, mode = { 'n', 'x' } },
        { 'mP', hidden = true, mode = { 'n', 'x' } },
        { 'mQ', hidden = true, mode = { 'n', 'x' } },
        { 'mR', hidden = true, mode = { 'n', 'x' } },
        { 'mS', hidden = true, mode = { 'n', 'x' } },
        { 'mT', hidden = true, mode = { 'n', 'x' } },
        { 'mU', hidden = true, mode = { 'n', 'x' } },
        { 'mV', hidden = true, mode = { 'n', 'x' } },
        { 'mW', hidden = true, mode = { 'n', 'x' } },
        { 'mX', hidden = true, mode = { 'n', 'x' } },
        { 'mY', hidden = true, mode = { 'n', 'x' } },
        { 'mZ', hidden = true, mode = { 'n', 'x' } },
      }
    end
  )
end)
