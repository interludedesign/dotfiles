local common = require("lsp.common")

local function on_attach(client, bufnr)
  common.on_attach(client, bufnr)
  vim.keymap.set("n", "gd", common.markdown_gd, { buffer = bufnr, silent = true })
end

return {
  cmd = { "marksman", "server" },
  filetypes = { "markdown", "markdown.mdx" },
  root_markers = { ".git", ".marksman.toml" },
  on_attach = on_attach,
  capabilities = common.capabilities,
  settings = {},
}
