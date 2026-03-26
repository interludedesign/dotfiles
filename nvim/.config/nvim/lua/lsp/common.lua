local M = {}

function M.on_attach(client, bufnr)
  local map = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
  end

  map("n", "gd", vim.lsp.buf.definition)
  map("n", "K", function()
    vim.lsp.buf.hover({ border = "rounded" })
  end)
  map("n", "gi", vim.lsp.buf.implementation)
  map("n", "gr", vim.lsp.buf.references)
  map("n", "<leader>ca", vim.lsp.buf.code_action)
  map("n", "gl", function()
    vim.diagnostic.open_float({ border = "rounded" })
  end)
  map("n", "ql", function()
    vim.diagnostic.setqflist()
    vim.cmd("copen")
  end)
end

function M.markdown_gd()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1

  local link = nil
  for start_pos, inner, end_pos in line:gmatch("()!?%[%[([^%]]+)%]%]()") do
    if col >= start_pos and col < end_pos then
      link = inner
      break
    end
  end

  if not link then
    vim.lsp.buf.definition()
    return
  end

  -- Strip heading/block refs and aliases (e.g. "My File#heading|alias" -> "My File")
  link = vim.trim(link:match("^([^#|]+)") or link)

  local root = vim.lsp.buf.list_workspace_folders()[1] or vim.fn.getcwd()
  local candidates = vim.fn.glob(root .. "/**/" .. link .. ".md", false, true)
  if #candidates == 0 then
    candidates = vim.fn.glob(root .. "/**/" .. link, false, true)
  end

  if #candidates > 0 then
    vim.cmd("edit " .. vim.fn.fnameescape(candidates[1]))
  else
    vim.notify("File not found: " .. link, vim.log.levels.WARN)
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

return M
