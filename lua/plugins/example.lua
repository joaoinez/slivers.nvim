-- [[ Example Plugin ]]

---@type LazySpec
return true and {}
  or {
    'example/plugin.nvim',
    enabled = true,
    version = '1.x',
    branch = 'main',
    name = 'example',
    dependencies = {
      'other/plugin.nvim',
    },
    build = ':Some command',
    main = 'text',
    priority = 1000,
    lazy = true,
    ft = 'lua',
    event = 'VeryLazy',
    cmd = { 'PluginCommand' },
    keys = {
      {
        '<leader>e',
        function() end,
        desc = 'Description',
      },
    },
    spec = {},
    opts = {},
    config = function() end,
    init = function() end,
  }
