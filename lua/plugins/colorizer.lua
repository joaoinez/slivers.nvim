---@type LazySpec
return {
  'NvChad/nvim-colorizer.lua',
  enabled = true,
  event = 'BufReadPre',
  opts = {
    filetypes = {
      'css',
      'javascript',
    },
    user_default_options = {
      names = true, -- "Name" codes like Blue or blue
      RGB = true, -- #RGB hex codes
      RRGGBB = true, -- #RRGGBB hex codes
      RRGGBBAA = false, -- #RRGGBBAA hex codes
      AARRGGBB = false, -- 0xAARRGGBB hex codes
      rgb_fn = false, -- CSS rgb() and rgba() functions
      hsl_fn = false, -- CSS hsl() and hsla() functions
      css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      mode = 'background', -- Set the display mode
      tailwind = true, -- Enable tailwind colors
      sass = { enable = true, parsers = { 'css' } }, -- Enable sass colors
      virtualtext = '󱓻',
      virtualtext_inline = false,
      virtualtext_mode = 'foreground',
      always_update = false,
    },
    buftypes = {
      '*',
      '!prompt',
      '!popup',
    },
    user_commands = true, -- Enable all or some usercommands
  },
}
