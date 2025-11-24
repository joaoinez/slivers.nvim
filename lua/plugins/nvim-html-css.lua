---@type LazySpec
return {
  'Jezda1337/nvim-html-css',
  enabled = true,
  cond = not vim.g.vscode,
  dependencies = {
    'saghen/blink.cmp',
  },
  event = 'BufReadPost',
  opts = {
    enable_on = {
      'html',
      'htmldjango',
      'php',
      'templ',
      'astro',
      'razor',
    },
    handlers = {
      definition = {
        bind = 'gcd',
      },
      hover = {
        bind = 'K',
        wrap = true,
        border = 'none',
        position = 'cursor',
      },
    },
    documentation = {
      auto_show = true,
    },
    style_sheets = {},
  },
}

-- INFO: To add project specific configurations, create a `.nvim.lua` file:
--
--[[
vim.g.html_css = {
  enable_on = { "html", "jsx" },  -- File types for this project only
  handlers = {
    definition = {
      bind = "gd"
    },
    hover = {
      bind = "K",
      wrap = true,
      border = "none",
      position = "cursor",
    }
  },
  documentation = {
    auto_show = true,
  },
  style_sheets = {
    -- Project-specific stylesheets
    "./src/styles/main.css",
    "./src/styles/components.css",
    "https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css",
  }
}
--]]
