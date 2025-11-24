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
  get = function() return vim.g.transparent_bg == true end,
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

Snacks.toggle({
  name = 'Animated Scroll',
  get = function() return vim.g.animated_scroll == true end,
  set = function(state)
    if state then
      vim.g.animated_scroll = true
      Snacks.scroll.enable()
    else
      vim.g.animated_scroll = false
      Snacks.scroll.disable()
    end
  end,
}):map '<leader>ta'

Snacks.toggle({
  name = 'Random Colorscheme',
  get = function() return vim.g.random_colorscheme == true end,
  set = function(state)
    local path = vim.fn.stdpath 'config' .. '/.slivers.json'
    if Slivers.misc.file_exists(path) then
      local config = vim.json.decode(Slivers.misc.read_file(path))

      if state then
        config.random_colorscheme = true

        Slivers.misc.write_file(path, vim.json.encode(config))
      else
        config.random_colorscheme = false

        Slivers.misc.write_file(path, vim.json.encode(config))
      end

      vim.schedule(function() vim.cmd 'cq' end)
    end
  end,
}):map '<leader>,r'
