local common = require("lsp.common")

return {
  cmd = { "ruby-lsp" },
  filetypes = { "ruby" },
  root_markers = { "Gemfile", ".git" },
  init_options = {
    formatter = "auto",
    linters = { "rubocop" },
  },
}
