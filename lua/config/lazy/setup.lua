-- [[ Setup lazy.nvim ]]
require('lazy').setup {
  spec = {
    { import = 'plugins' },
  },
  checker = { enabled = true, notify = false },
  change_detection = {
    notify = false,
  }
}
