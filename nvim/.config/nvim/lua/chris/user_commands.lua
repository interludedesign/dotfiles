local command = vim.api.nvim_create_user_command

command('Format', ':LspZeroFormat', {})
command('DisableDiagnostics', ':lua vim.diagnostic.disable()', {})
command('EnableDiagnostics', ':lua vim.diagnostic.disable()', {})

command("FoldSpecExamples", function()
	require('chris.treesitter_rspec').create_folds()
end, {})
