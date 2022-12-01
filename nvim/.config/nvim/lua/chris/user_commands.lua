local command = vim.api.nvim_create_user_command

command('Format', ':Neoformat', {})
command('DisableDiagnostics', ':lua vim.diagnostic.disable()', {})
command('EnableDiagnostics', ':lua vim.diagnostic.disable()', {})
