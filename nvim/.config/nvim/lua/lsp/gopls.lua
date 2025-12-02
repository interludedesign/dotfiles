local common = require("lsp.common")

return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gotmpl", "gowork" },
  root_markers = { "go.work", "go.mod", ".git" },
  on_attach = common.on_attach,
  capabilities = common.capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
}
