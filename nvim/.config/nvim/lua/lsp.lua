vim.lsp.set_log_level("INFO")

local servers = { "lua_ls", "ruby_lsp", "ts_ls", "gopls", "omnisharp", "bash-language-server", "marksman"}

for _, name in ipairs(servers) do
  -- The lsp docs say the lsp dir is autolaoded, but I can't get it to work, so manually requiring them here
  vim.lsp.config(name, require("lsp." .. name))

  -- Enable each lsp
  vim.lsp.enable(name)
end
