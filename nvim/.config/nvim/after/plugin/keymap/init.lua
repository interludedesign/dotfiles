-- Copy current file to clipboard
vim.api.nvim_set_keymap("n", "<leader>c", ":let @+=expand('%:p')<CR>", {noremap = true})

-- Run Plenary tests
vim.api.nvim_set_keymap("n", "<leader><leader>t", "<Plug>PlenaryTestFile", {noremap = true})

-- Spec runner
vim.api.nvim_set_keymap("n", "<leader>s", ":lua require('chris.utils').run_spec_in_tmux()<CR>", {noremap = true})

-- Keep result in center screen when hitting n
vim.api.nvim_set_keymap("n", "n", "nzz", {noremap = true})
vim.api.nvim_set_keymap("n", "N", "Nzz", {noremap = true})

-- Make Shift+Y yank to end of line, rather than the entire line
vim.api.nvim_set_keymap("n", "Y", "y$", {noremap = true})

-- Paste in visual mode without copying
vim.api.nvim_set_keymap("x", "p", "pgvy", {noremap = true})

-- Clear all selections
vim.api.nvim_set_keymap("n", "<leader>cl", ":noh<CR>", {noremap = true})

-- Open quickfix list loaded with Rspec errors
vim.api.nvim_set_keymap("n", "<leader>q", ":cg /tmp/quickfix.out | cwindow<CR>", {noremap = true})

-- Shift text up or down
vim.api.nvim_set_keymap("v", "<leader>J", ":m '>+1<CR>gv=gv", {noremap = true})
vim.api.nvim_set_keymap("v", "<leader>K", ":m '<-2<CR>gv=gv", {noremap = true})

-- Find the alternate file for the given path and open it in a split
vim.keymap.set("n", "<leader>.", function()
	require('chris.utils').open_alternate_path(nil, ':vsplit')
end, {noremap = true})

-- Return to normal mode and save
vim.api.nvim_set_keymap("i", "kj", "<ESC>:w<CR>l", {noremap = true})

-- NERDTree
vim.api.nvim_set_keymap("n", "<leader>te", ":NERDTree<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>tr", ":NERDTreeFind<CR>", {noremap = true})

-- Save and source current buffer
vim.api.nvim_set_keymap("n", "<leader><leader>x", ":w | source<CR>", {noremap = true})

-- Source $MYVIMRC
vim.api.nvim_set_keymap("n", "<leader><leader>s", ":source $MYVIMRC<CR>", {noremap = true})

-- Toggle git blame
vim.api.nvim_set_keymap("n", "<leader>gb", ":lua require('chris.utils').toggle_blame()<CR>", {noremap = true})

-- Find and replace under cursor
vim.api.nvim_set_keymap("n", "<leader>r", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", {noremap = true})
