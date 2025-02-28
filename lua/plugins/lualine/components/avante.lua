local M = {}

local provider = require('avante.config').provider

local provider1 = require('avante.config').dual_boost.first_provider
local provider2 = require('avante.config').dual_boost.second_provider

local colors = {
  claude = '#d97757',
  ['claude-reasoning'] = '#d97757',
  ['deepseek-r1'] = '#4D6BFE',
  ['o3-mini-high'] = '#76a89c',
  ['qwen2.5-coder'] = '#6738F0',
  ['mistrall-small'] = '#F97315',
  ['groq-llama'] = '#106AFF',
  ['ollama-qwen'] = '#6738F0',
  gemini = '#3a92db',
  cohere = '#d2a1de',
}

local function icon(p) return IconSliver.lualine.ai[p] or '' end

function M.init() return provider end

function M.icon() return icon(provider) end

function M.color() return colors[provider] end

function M.dual_boost() return require('avante.config').dual_boost.enabled end

function M.provider1() return provider1 end

function M.provider1_icon() return icon(provider1) end

function M.provider1_color() return colors[provider1] end

function M.provider2() return provider2 end

function M.provider2_icon() return icon(provider2) end

function M.provider2_color() return colors[provider2] end

return M
