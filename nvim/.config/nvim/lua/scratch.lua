-- This is a scratch file for testing lua code
-- Source the file with <leader><leader>x or :source %
local utils = require("utils")

-- List all of nvim's lsp client capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

utils.floating_window.show(capabilities, "lua")
