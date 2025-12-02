local common = require("lsp.common")

return {
  cmd = { "ruby-lsp" },
  filetypes = { "ruby" },
  root_markers = { "Gemfile", ".git" },
  on_attach = common.on_attach,
  capabilities = common.capabilities,
  init_options = {
    formatter = "auto",
    linters = { "rubocop" },
  },
}
