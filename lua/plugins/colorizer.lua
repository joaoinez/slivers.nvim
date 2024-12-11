return {
  'NvChad/nvim-colorizer.lua',
  event = 'BufReadPre',
  opts = {
    filetypes = { '*' },
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
      -- Highlighting mode.  'background'|'foreground'|'virtualtext'
      mode = 'background', -- Set the display mode
      -- Tailwind colors.  boolean|'normal'|'lsp'|'both'.  True is same as normal
      tailwind = 'both', -- Enable tailwind colors
      -- parsers can contain values used in |user_default_options|
      sass = { enable = true, parsers = { 'css' } }, -- Enable sass colors
      -- Virtualtext character to use
      virtualtext = '󱓻',
      -- Display virtualtext inline with color
      virtualtext_inline = true,
      -- Virtualtext highlight mode: 'background'|'foreground'
      virtualtext_mode = 'foreground',
      -- update color values even if buffer is not focused
      -- example use: cmp_menu, cmp_docs
      always_update = true,
    },
    -- all the sub-options of filetypes apply to buftypes
    buftypes = {},
    -- Boolean | List of usercommands to enable
    user_commands = true, -- Enable all or some usercommands
  },
}
