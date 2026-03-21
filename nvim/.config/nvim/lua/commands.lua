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

command("Pascal", function()
  case_converters.to_pascal()
end, { desc = "Convert word under cursor to PascalCase (auto-detects snake, camel, kebab, etc.)" })

command("Camel", function()
  case_converters.to_camel()
end, { desc = "Convert word under cursor to camelCase (auto-detects snake, pascal, kebab, etc.)" })
