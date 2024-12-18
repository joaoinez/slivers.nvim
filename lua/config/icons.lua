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
  virtual = '● ',
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
  },
}

M.lualine = {
  section_separators = { left = '', right = '' },
  component_separators = { left = '', right = '' },
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
  },
}

return M
