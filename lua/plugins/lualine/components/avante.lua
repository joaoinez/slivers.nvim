local M = {}

local provider = require('avante.config').provider

local provider1 = require('avante.config').dual_boost.first_provider
local provider2 = require('avante.config').dual_boost.second_provider

local function icon(provider_name)
  if provider_name:match 'claude' then
    return '󰛄'
  elseif provider_name:match 'deepseek' then
    return ''
  elseif provider_name:match 'o3' then
    return ''
  elseif provider_name:match 'qwen' then
    return ''
  elseif provider_name:match 'mistrall' then
    return ''
  elseif provider_name:match 'llama' then
    return ''
  elseif provider_name:match 'gemini' then
    return '󰫢'
  elseif provider_name:match 'cohere' then
    return '󰺠'
  else
    return ''
  end
end

local function color(provider_name)
  if provider_name:match 'claude' then
    return '#d97757'
  elseif provider_name:match 'deepseek' then
    return '#4D6BFE'
  elseif provider_name:match 'o3' then
    return '#76a89c'
  elseif provider_name:match 'qwen' then
    return '#6738F0'
  elseif provider_name:match 'mistrall' then
    return '#F97315'
  elseif provider_name:match 'llama' then
    return '#106AFF'
  elseif provider_name:match 'gemini' then
    return '#3a92db'
  elseif provider_name:match 'cohere' then
    return '#d2a1de'
  end

  return '#ffffff'
end

function M.init() return provider end

function M.icon() return icon(provider) end
function M.color() return color(provider) end

function M.dual_boost() return require('avante.config').dual_boost.enabled end

function M.provider1() return provider1 end
function M.provider1_icon() return icon(provider1) end

function M.provider1_color() return color(provider1) end
function M.provider2() return provider2 end

function M.provider2_icon() return icon(provider2) end
function M.provider2_color() return color(provider2) end

return M
