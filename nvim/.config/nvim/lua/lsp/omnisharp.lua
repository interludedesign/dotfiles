local common = require("lsp.common")

return {
  cmd = { "/usr/bin/dotnet", "/home/chris/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
  filetypes = { "cs" },
  root_markers = { "*.sln", "*.csproj", ".git" },
  on_attach = common.on_attach,
  capabilities = common.capabilities,
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
  enable_import_completion = true,
}
