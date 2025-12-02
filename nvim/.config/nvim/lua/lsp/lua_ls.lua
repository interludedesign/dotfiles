local common = require("lsp.common")

return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
  settings = {
    Lua = {
      runtime = {
        -- Neovim uses LuaJIT
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" }, -- stop "undefined global vim"
      },
      workspace = {
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
