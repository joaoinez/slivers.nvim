local M = {}

M.cmp = {
  Text = '',
  Method = '󰊕',
  Function = '󰊕',
  Constructor = '󰒓',

  Field = '',
  Variable = '󰀫',
  Property = '󰖷',

  Class = '',
  Interface = '',
  Struct = '󰆼',
  Module = '',

  Unit = '',
  Value = '󰦨',
  Enum = '',
  EnumMember = '',

  Keyword = '󰻾',
  Constant = '󰏿',

  Snippet = '',
  Color = '󱓻',
  File = '󰈔',
  Reference = '󰬲',
  Folder = '',
  Event = '󱐋',
  Operator = '',
  TypeParameter = '',

  Array = '',
  Boolean = '󰨙',
  Control = '',
  Collapsed = '',
  Key = '',
  Namespace = '󰦮',
  Null = '',
  Number = '󰎠',
  Object = '',
  Package = '',
  String = '',

  Codeium = '',
  Copilot = '',
  Supermaven = '',
  TabNine = '',
}

M.dap = {
  ui = {
    expanded = '▾',
    collapsed = '▸',
    current_frame = '*',
  },
  breakpoints = {
    Breakpoint = '',
    BreakpointCondition = '',
    BreakpointRejected = '',
    LogPoint = '',
    Stopped = '',
  },
}

M.diagnostics = {
  error = '',
  warn = '',
  info = '',
  hint = '',
  virtual = '●',
  down = '󱞣',
}

M.git = {
  signs = {
    add = { text = '▎' },
    change = { text = '▎' },
    delete = { text = '' },
    topdelete = { text = '' },
    changedelete = { text = '▎' },
    untracked = { text = '▎' },
  },
  staged = {
    add = { text = '▎' },
    change = { text = '▎' },
    delete = { text = '' },
    topdelete = { text = '' },
    changedelete = { text = '▎' },
    untracked = { text = '▎' },
  },
}

M.lualine = {
  section_separators = function()
    return vim.g.lualine_borders and { left = '', right = '' } or { left = '', right = '' }
  end,
  component_separators = function()
    return vim.g.lualine_borders and { left = '┃', right = '┃' } or { left = '', right = '' }
  end,
  file = {
    modified = '',
    readonly = '',
  },
  diff = {
    added = ' ',
    modified = ' ',
    removed = ' ',
  },
  lsp = {
    lua_ls = '󰢱',
    eslint = '󰱺',
    tailwindcss = '󱏿',
    volar = '󰡄',
    vtsls = '󰛦',
    gopls = '󰟓',
    basedpyright = '󰌠',
    ruff = '',
    yamlls = '',
    kulala = '󱜿',
    bashls = '',
    jsonls = '',
    cssls = '',
    copilot = '',
  },
}

return M
