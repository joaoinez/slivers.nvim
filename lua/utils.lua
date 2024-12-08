-- [[ General Utils ]]

local M = {}

M.autocmd = vim.api.nvim_create_autocmd

--- @param name string
function M.augroup(name)
  return vim.api.nvim_create_augroup('slivers_' .. name, { clear = true })
end

--- Adds autocmds to a specific buffer if they don't already exist.
---
--- @param augroup string       The name of the autocmd group to which the autocmds belong.
--- @param bufnr number         The buffer number to which the autocmds should be applied.
--- @param autocmds table|any  A table or a single autocmd definition containing the autocmds to add.
function M.add_autocmds_to_buffer(augroup, bufnr, autocmds)
  -- Check if autocmds is a list, if not convert it to a list
  if not vim.islist(autocmds) then autocmds = { autocmds } end

  -- Attempt to retrieve existing autocmds associated with the specified augroup and bufnr
  local cmds_found, cmds =
    pcall(vim.api.nvim_get_autocmds, { group = augroup, buffer = bufnr })

  -- If no existing autocmds are found or the cmds_found call fails
  if not cmds_found or vim.tbl_isempty(cmds) then
    -- Create a new augroup if it doesn't already exist
    vim.api.nvim_create_augroup(augroup, { clear = false })

    -- Iterate over each autocmd provided
    for _, autocmd in ipairs(autocmds) do
      -- Extract the events from the autocmd and remove the events key
      local events = autocmd.events
      autocmd.events = nil

      -- Set the group and buffer keys for the autocmd
      autocmd.group = augroup
      autocmd.buffer = bufnr

      -- Create the autocmd
      vim.api.nvim_create_autocmd(events, autocmd)
    end
  end
end

--- Deletes autocmds associated with a specific buffer and autocmd group.
---
--- @param augroup string The name of the autocmd group from which the autocmds should be removed.
--- @param bufnr number The buffer number from which the autocmds should be removed.
function M.del_autocmds_from_buffer(augroup, bufnr)
  -- Attempt to retrieve existing autocmds associated with the specified augroup and bufnr
  local cmds_found, cmds =
    pcall(vim.api.nvim_get_autocmds, { group = augroup, buffer = bufnr })

  -- If retrieval was successful
  if cmds_found then
    -- Map over each retrieved autocmd and delete it
    vim.tbl_map(function(cmd) vim.api.nvim_del_autocmd(cmd.id) end, cmds)
  end
end

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

--- Check if a plugin is defined in lazy. Useful with lazy loading
--- when a plugin is not necessarily loaded yet.
--- @param plugin string The plugin to search for.
--- @return boolean available # Whether the plugin is available.
function M.is_available(plugin)
  local lazy_config_avail, lazy_config = pcall(require, 'lazy.core.config')
  return lazy_config_avail and lazy_config.spec.plugins[plugin] ~= nil
end

--- Add syntax matching rules for highlighting URLs/URIs.
function M.set_url_effect()
  --- regex used for matching a valid URL/URI string
  local url_matcher = '\\v\\c%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)'
    .. '%([&:#*@~%_\\-=?!+;/0-9a-z]+%(%([.;/?]|[.][.]+)'
    .. '[&:#*@~%_\\-=?!+/0-9a-z]+|:\\d+|,%(%(%(h?ttps?|ftp|file|ssh|git)://|'
    .. '[a-z]+[@][a-z]+[.][a-z]+:)@![0-9a-z]+))*|\\([&:#*@~%_\\-=?!+;/.0-9a-z]*\\)'
    .. '|\\[[&:#*@~%_\\-=?!+;/.0-9a-z]*\\]|\\{%([&:#*@~%_\\-=?!+;/.0-9a-z]*'
    .. '|\\{[&:#*@~%_\\-=?!+;/.0-9a-z]*})\\})+'

  M.delete_url_effect()
  if vim.g.url_effect_enabled then
    vim.fn.matchadd('HighlightURL', url_matcher, 15)
  end
end

--- Delete the syntax matching rules for URLs/URIs if set.
function M.delete_url_effect()
  for _, match in ipairs(vim.fn.getmatches()) do
    if match.group == 'HighlightURL' then vim.fn.matchdelete(match.id) end
  end
end

--- Convenient wapper to save code when we Trigger events.
--- To listen for an event triggered by this function you can use `autocmd`.
--- @param event string Name of the event.
--- @param is_urgent boolean|nil If true, trigger directly instead of scheduling. Useful for startup events.
-- @usage To run a User event:   `trigger_event("User MyUserEvent")`
-- @usage To run a Neovim event: `trigger_event("BufEnter")
function M.trigger_event(event, is_urgent)
  -- define behavior
  local function trigger()
    local is_user_event = string.match(event, "^User ") ~= nil
    if is_user_event then
      event = event:gsub("^User ", "")
      vim.api.nvim_exec_autocmds("User", { pattern = event, modeline = false })
    else
      vim.api.nvim_exec_autocmds(event, { modeline = false })
    end
  end

  -- execute
  if is_urgent then
    trigger()
  else
    vim.schedule(trigger)
  end
end

return M
