local common = require("lsp.common")

return {
  cmd = { "dotnet", "/usr/local/bin/omnisharp/OmniSharp.dll" },
  filetypes = { "cs" },
  root_markers = { "*.sln", "*.csproj", ".git" },
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
  enable_import_completion = true,
}
