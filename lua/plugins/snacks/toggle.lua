-- Create some toggle mappings
Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>ts'
Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>tw'
Snacks.toggle.option('relativenumber', { name = 'Relative Line Numbers' }):map '<leader>tL'
Snacks.toggle.diagnostics():map '<leader>tx'
Snacks.toggle.treesitter():map '<leader>tT'
Snacks.toggle.inlay_hints():map '<leader>th'

Snacks.toggle({
  name = 'Dark Mode',
  get = function() return vim.o.background == 'dark' end,
  set = function(state)
    if state then
      vim.o.background = 'dark'
    else
      vim.o.background = 'light'
    end
  end,
}):map '<leader>tm'

Snacks.toggle({
  name = 'Transparent Background',
  get = function()
    local path = vim.fn.stdpath 'config' .. '/.slivers.json'

    if Slivers.misc.file_exists(path) then
      local config = vim.json.decode(Slivers.misc.read_file(path))

      return config.transparent_bg
    end

    return false
  end,
  set = function(state)
    local path = vim.fn.stdpath 'config' .. '/.slivers.json'
    if Slivers.misc.file_exists(path) then
      local config = vim.json.decode(Slivers.misc.read_file(path))

      if state then
        config.transparent_bg = true

        Slivers.misc.write_file(path, vim.json.encode(config))
      else
        config.transparent_bg = false

        Slivers.misc.write_file(path, vim.json.encode(config))
      end

      vim.schedule(function() vim.cmd 'cq' end)
    end
  end,
}):map '<leader>,b'
