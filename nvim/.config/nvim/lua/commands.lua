local command = vim.api.nvim_create_user_command

command('DisableDiagnostics', ':lua vim.diagnostic.disable()', {})