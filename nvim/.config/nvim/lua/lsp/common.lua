local M = {}

function M.on_attach(client, bufnr)
  local map = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
  end

  map("n", "gd", vim.lsp.buf.definition)
  map("n", "K", vim.lsp.buf.hover)
  map("n", "gi", vim.lsp.buf.implementation)
  map("n", "gr", vim.lsp.buf.references)
  map("n", "<leader>ca", vim.lsp.buf.code_action)
  map("n", "gl", vim.diagnostic.open_float)
  map("n", "ql", function()
    vim.diagnostic.setqflist()
    vim.cmd("copen")
  end)
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

return M
