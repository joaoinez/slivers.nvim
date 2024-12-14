---@class utils.keymaps
local M = {}

-- TODO: Replace these functions with LazyVim's implementation

--- Get an empty table of mappings with a key for each map mode.
--- @return table<string,table> # a table with entries for each map mode.
function M.get_mappings_template()
  local maps = {}
  for _, mode in ipairs {
    '',
    'n',
    'v',
    'x',
    's',
    'o',
    '!',
    'i',
    'l',
    'c',
    't',
    'ia',
    'ca',
    '!a',
  } do
    maps[mode] = {}
  end
  return maps
end

--- Set a table of mappings.
--- This wrapper prevents a  boilerplate code, and takes care of `whichkey.nvim`.
--- @param map_table table A nested table where the first key is the vim mode,
---                        the second key is the key to map, and the value is
---                        the function to set the mapping to.
--- @param base? table A base set of options to set on every keybinding.
function M.set_mappings(map_table, base)
  -- iterate over the first keys for each mode
  for mode, maps in pairs(map_table) do
    -- iterate over each keybinding set in the current mode
    for keymap, options in pairs(maps) do
      -- build the options for the command accordingly
      if options then
        local cmd
        local keymap_opts = base or {}
        if type(options) == 'string' or type(options) == 'function' then
          cmd = options
        else
          cmd = options[1]
          keymap_opts = vim.tbl_deep_extend('force', keymap_opts, options)
          keymap_opts[1] = nil
        end
        if not cmd then -- if which-key mapping, queue it
          keymap_opts[1], keymap_opts.mode = keymap, mode
          if not keymap_opts.group then keymap_opts.group = keymap_opts.desc end
          if not M.which_key_queue then M.which_key_queue = {} end
          table.insert(M.which_key_queue, keymap_opts)
        else -- if not which-key mapping, set it
          vim.keymap.set(mode, keymap, cmd, keymap_opts)
        end
      end
    end
  end
  -- if which-key is loaded already, register
  if package.loaded['which-key'] then M.which_key_register() end
end

--- Register queued which-key mappings.
function M.which_key_register()
  if M.which_key_queue then
    local wk_avail, wk = pcall(require, 'which-key')
    if wk_avail then
      wk.add(M.which_key_queue)
      M.which_key_queue = nil
    end
  end
end

return M
