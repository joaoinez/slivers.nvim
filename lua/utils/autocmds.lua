---@class utils.autocmds
local M = {}

M.autocmd = vim.api.nvim_create_autocmd

--- @param name string
function M.augroup(name) return vim.api.nvim_create_augroup('slivers_' .. name, { clear = true }) end

--- Adds autocmds to a specific buffer if they don't already exist.
---
--- @param augroup string       The name of the autocmd group to which the autocmds belong.
--- @param bufnr number         The buffer number to which the autocmds should be applied.
--- @param autocmds table|any  A table or a single autocmd definition containing the autocmds to add.
function M.add_autocmds_to_buffer(augroup, bufnr, autocmds)
  -- Check if autocmds is a list, if not convert it to a list
  if not vim.islist(autocmds) then autocmds = { autocmds } end

  -- Attempt to retrieve existing autocmds associated with the specified augroup and bufnr
  local cmds_found, cmds = pcall(vim.api.nvim_get_autocmds, { group = augroup, buffer = bufnr })

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
  local cmds_found, cmds = pcall(vim.api.nvim_get_autocmds, { group = augroup, buffer = bufnr })

  -- If retrieval was successful
  if cmds_found then
    -- Map over each retrieved autocmd and delete it
    vim.tbl_map(function(cmd) vim.api.nvim_del_autocmd(cmd.id) end, cmds)
  end
end

return M
