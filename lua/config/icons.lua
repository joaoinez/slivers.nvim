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
  minuet = '',
  codecompanion = '',
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

return M
