local command = vim.api.nvim_create_user_command
local docs_util = require("utils.docs")
local date_util = require("utils.date")
local testing_util = require("utils.testing")

command("DisableDiagnostics", ":lua vim.diagnostic.disable()", {})
command("LspInfo", ":checkhealth vim.lsp", {})
command("ExtractSection", function()
  docs_util.extract_section()
end, { range = true })

date_util.setup()

command("Test", function()
  testing_util.dotnet_test_to_clipboard()
end, { desc = "Copy dotnet test command for current file to clipboard" })
