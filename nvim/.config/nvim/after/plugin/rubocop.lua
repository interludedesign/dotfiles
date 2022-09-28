-- Set up rubocop config
vim.g.vimrubocop_config = '~/.rubocop.yml'
vim.g.vimrubocop_keymap = 0
-- vim.api.nvim_set_keymap("n", "<leader>r", ":RuboCop<CR>", {noremap = true})

-- ALE - Asynchronous Lint Engine
vim.g.ale_ruby_rubocop_executable = 'rubocop'

-- No checks on open
vim.g.ale_lint_on_enter = 1

-- Check on save
vim.g.ale_lint_on_save = 1

-- Check on text change
vim.g.ale_lint_on_text_changed = 1

-- millisecond delay before checking
vim.g.ale_lint_delay = 2000

vim.g.ale_warn_about_trailing_whitespace = 1

-- Set specific linters
--
-- TODO: Not sure how to format this for lua
-- vim.g.ale_linters = { 'ruby': ['rubocop'], 'javascript': ['eslint'] }
-- vim.g.ale_statusline_format = ['✖ %d', '⚠ %d', '']
--
vim.g.ale_sign_error = 'x '
vim.g.ale_sign_warning = '? '
vim.g.ale_set_highlights = 1
