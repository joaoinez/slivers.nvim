---@type LazySpec
return {
  'MeanderingProgrammer/render-markdown.nvim',
  enabled = true,
  ft = { 'markdown', 'norg', 'rmd', 'org', 'Avante' },
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePost' },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    file_types = { 'markdown', 'norg', 'rmd', 'org', 'Avante' },
    code = {
      sign = false,
      width = 'block',
      right_pad = 1,
    },
    heading = {
      sign = false,
    },
  },
  config = function(_, opts)
    require('render-markdown').setup(opts)
    require('snacks')
      .toggle({
        name = 'Render Markdown',
        get = function() return require('render-markdown.state').enabled end,
        set = function(enabled)
          local m = require 'render-markdown'
          if enabled then
            m.enable()
          else
            m.disable()
          end
        end,
      })
      :map '<leader>tM'
  end,
}
