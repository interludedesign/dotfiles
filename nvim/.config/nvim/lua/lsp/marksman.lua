local common = require("lsp.common")

return {
  cmd = { "marksman", "server" },
  filetypes = { "markdown", "markdown.mdx" },
  root_markers = { ".git", ".marksman.toml" },
  on_attach = common.on_attach,
  capabilities = common.capabilities,
  settings = {},
}
