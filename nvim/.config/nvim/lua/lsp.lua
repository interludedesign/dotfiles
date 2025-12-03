vim.lsp.set_log_level("INFO")

local servers = { "lua_ls", "ruby_lsp", "ts_ls", "gopls", "omnisharp" }

for _, name in ipairs(servers) do
  -- The lsp docs say the lsp dir is autolaoded, but I can't get it to work, so manually requiring them here
  vim.lsp.config(name, require("lsp." .. name))

  -- Enable each lsp
for _, name in ipairs { "lua_ls", "ruby_lsp", "ts_ls", "gopls", "omnisharp" } do
  vim.lsp.enable(name)
end
