local M = {}

M.config = {
  init_options = {
    vue = {
      hybridMode = true,
    },
  },
}

M.plugin = {
  name = '@vue/typescript-plugin',
  location = Slivers.mason.get_pkg_path('vue-language-server', '/node_modules/@vue/language-server'),
  languages = { 'vue' },
  configNamespace = 'typescript',
  enableForWorkspaceTypeScriptVersions = true,
}

return M
