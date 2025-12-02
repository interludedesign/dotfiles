for _, name in ipairs { "lua_ls", "ruby_lsp", "ts_ls", "gopls", "omnisharp" } do
  vim.lsp.enable(name)
end
