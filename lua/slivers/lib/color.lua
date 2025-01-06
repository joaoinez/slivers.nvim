-- INFO: From https://github.com/rebelot/kanagawa.nvim/blob/master/lua/kanagawa/lib/color.lua
--
--[[
Copyright (c) 2021 Tommaso Laurenzi

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

---@diagnostic disable: duplicate-set-field

local hsluv = require 'slivers.lib.hsluv'

---@class HSLuvColor
local Color = {}
local Color_mt = {
  __index = Color,
  __tostring = function(self) return self:to_hex() end,
}

local function none_to_hex() return 'NONE' end

---Create a new HSLuv color object from a RGB hex string
---@param hex string Hex color
---@return HSLuvColor
function Color.new(hex)
  if hex:lower() == 'none' then return setmetatable({ H = 0, S = 0, L = 0, to_hex = none_to_hex }, Color_mt) end
  local H, S, L = unpack(hsluv.hex_to_hsluv(hex))
  return setmetatable({ H = H, S = S, L = L }, Color_mt)
end

function Color:to_rgb() return hsluv.hsluv_to_rgb { self.H, self.S, self.L } end

function Color:to_hex() return hsluv.hsluv_to_hex { self.H, self.S, self.L } end

local function blendRGB(a, b, r)
  local c = {}
  for i = 1, 3 do
    c[i] = math.sqrt((1 - r) * math.pow(a[i], 2) + r * math.pow(b[i], 2))
  end
  return c
end

--- Blend Color with another color (hex)
---@param b string Hex color
---@param r number Blend ratio [0, 1]
---@return HSLuvColor
function Color:blend(b, r)
  if b:lower() == 'none' then return self end
  local c = blendRGB(self:to_rgb(), hsluv.hex_to_rgb(b), r)
  self.H, self.S, self.L = unpack(hsluv.rgb_to_hsluv(c))
  return self
end

---@param r number Brighten ratio [-1, 1]
---@param bg? string background color, if light, r = -r
---@return HSLuvColor
function Color:brighten(r, bg)
  if bg and bg:lower() == 'none' then return self end
  local bg_lightness = bg and hsluv.hex_to_hsluv(bg)[3] or 0
  r = bg_lightness > 50 and -r or r

  local lspace = r > 0 and 100 - self.L or self.L
  self.L = self.L + lspace * r
  return self
end

---@param r number Saturate ratio [-1, 1]
---@return HSLuvColor
function Color:saturate(r)
  local lspace = r > 0 and 100 - self.S or self.S
  self.S = self.S + lspace * r
  return self
end

local M = {}
return setmetatable(M, {
  __call = function(_, ...) return Color.new(...) end,
})
