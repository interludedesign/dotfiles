local common = require("lsp.common")

return {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_markers = {
    "tsconfig.json",
    "jsconfig.json",
    "package.json",
    ".git",
  },
  on_attach = common.on_attach,
  capabilities = common.capabilities,
  init_options = {
    hostInfo = "neovim",
  },
}
