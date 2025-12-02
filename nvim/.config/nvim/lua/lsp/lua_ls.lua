local common = require("lsp.common")

return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
  on_attach = common.on_attach,
  capabilities = common.capabilities,
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
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library",
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
