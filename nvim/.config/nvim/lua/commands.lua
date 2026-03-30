local command = vim.api.nvim_create_user_command
local docs_util = require("utils.docs")
local date_util = require("utils.date")
local testing_util = require("utils.testing")
local case_converters = require("utils.case_converters")

command("DisableDiagnostics", ":lua vim.diagnostic.disable()", {})
command("LspInfo", ":checkhealth vim.lsp", {})
command("ExtractSection", function()
  docs_util.extract_section()
end, { range = true })

date_util.setup()

command("Test", function()
  testing_util.dotnet_test_to_clipboard()
end, { desc = "Copy dotnet test command for current file to clipboard" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      vim.notify(client.name .. " ready", vim.log.levels.INFO, { title = "LSP" })
    end
  end,
})

vim.api.nvim_create_autocmd("LspDetach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      vim.notify(client.name .. " stopped", vim.log.levels.WARN, { title = "LSP" })
    end
  end,
})

command("Pascal", function()
  case_converters.to_pascal()
end, { desc = "Convert word under cursor to PascalCase (auto-detects snake, camel, kebab, etc.)" })

command("Camel", function()
  case_converters.to_camel()
end, { desc = "Convert word under cursor to camelCase (auto-detects snake, pascal, kebab, etc.)" })

command("SqlLoad", function()
  vim.api.nvim_command("write")
  vim.fn.setenv("NVIM_SQL_FILE", vim.api.nvim_buf_get_name(0))
  local shell = vim.fn.getenv("SHELL") or "sh"
  vim.cmd("botright split | resize 15 | terminal " .. shell .. " -i -c 'psql-load \"$NVIM_SQL_FILE\"'")
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_create_autocmd("TermClose", {
    buffer = buf,
    once = true,
    callback = function()
      vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true })
    end,
  })
end, { desc = "Load the current SQL file into PostgreSQL via psql-load" })
