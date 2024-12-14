local M = {}

---@param name "autocmds" | "options" | "keymaps"
function M.load(name)
  local function _load(mod)
    if name == 'options' then
      require(mod)
    elseif require('lazy.core.cache').find(mod)[1] then
      require('lazy.core.util').try(function() require(mod) end, { msg = 'Failed loading ' .. mod })
    end
  end

  local pattern = 'LazySlivers' .. name:sub(1, 1):upper() .. name:sub(2)

  _load('config.' .. name)

  if vim.bo.filetype == 'lazy' then
    -- HACK: LazySlivers may have overwritten options of the Lazy ui, so reset this here
    vim.cmd [[do VimResized]]
  end
  vim.api.nvim_exec_autocmds('User', { pattern = pattern, modeline = false })
end

function M.init()
  -- [[ Load Options ]]
  M.load 'options'

  -- [[ Initialize Lazy ]]
  require 'config.lazy'

  -- autocmds can be loaded lazily when not opening a file
  local lazy_autocmds = vim.fn.argc(-1) == 0
  if not lazy_autocmds then
    -- [[ Load Autocmds ]]
    M.load 'autocmds'
  end

  local group = vim.api.nvim_create_augroup('LazySlivers', { clear = true })
  vim.api.nvim_create_autocmd('User', {
    group = group,
    pattern = 'VeryLazy',
    callback = function()
      if lazy_autocmds then
        -- [[ Load Autocmds ]]
        M.load 'autocmds'
      end
      -- [[ Load Keymaps ]]
      M.load 'keymaps'
    end,
  })

  -- [[ Apply Colorscheme ]]
  vim.cmd.colorscheme 'catppuccin'
end

return M
