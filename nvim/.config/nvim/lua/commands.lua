local command = vim.api.nvim_create_user_command
local docs_util = require("utils.docs")
local date_util = require("utils.date")

command("DisableDiagnostics", ":lua vim.diagnostic.disable()", {})
command("LspInfo", ":checkhealth vim.lsp", {})
command("ExtractSection", function()
  docs_util.extract_section()
end, { range = true })

date_util.setup()
