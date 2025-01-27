-- Copy current file to clipboard
vim.keymap.set("n", "<leader>c", ":let @+=expand('%:p')<CR>", {noremap = true})

-- Run Plenary tests
vim.keymap.set("n", "<leader><leader>t", "<Plug>PlenaryTestFile", {noremap = true})

-- Spec runner
vim.keymap.set("n", "<leader>s", ":lua require('utils.testing').run_spec_in_tmux()<CR>", {noremap = true})

-- Go runner
vim.keymap.set("n", "<leader><leader>r", ":lua require('utils.testing').run_go_in_tmux()<CR>", {noremap = true})

-- Keep result in center screen when hitting n
vim.keymap.set("n", "n", "nzz", {noremap = true})
vim.keymap.set("n", "N", "Nzz", {noremap = true})

-- Make Shift+Y yank to end of line, rather than the entire line
vim.keymap.set("n", "Y", "y$", {noremap = true})

-- Paste in visual mode without copying
vim.keymap.set("x", "p", "pgvy", {noremap = true})

-- Clear all selections
vim.keymap.set("n", "<leader>cl", ":noh<CR>", {noremap = true})

-- Open quickfix list loaded with Rspec errors
vim.keymap.set("n", "<leader>q", ":cg /tmp/quickfix.out | cwindow<CR>", {noremap = true})

-- Shift text up or down
vim.keymap.set("v", "<leader>J", ":m '>+1<CR>gv=gv", {noremap = true})
vim.keymap.set("v", "<leader>K", ":m '<-2<CR>gv=gv", {noremap = true})

-- Find the alternate file for the given path and open it in a split
vim.keymap.set("n", "<leader>.", function()
	require('utils.alternate_path').open(nil, ':vsplit')
end, {noremap = true})

-- Return to normal mode and save
vim.keymap.set("i", "kj", "<ESC>:w<CR>l", {noremap = true})

-- NERDTree
vim.keymap.set("n", "<leader>te", ":NERDTree<CR>", {noremap = true})
vim.keymap.set("n", "<leader>tr", ":NERDTreeFind<CR>", {noremap = true})

-- Save and source current buffer
vim.keymap.set("n", "<leader><leader>x", ":w | source<CR>", {noremap = true})

-- Source $MYVIMRC
vim.keymap.set("n", "<leader><leader>s", ":source $MYVIMRC<CR>", {noremap = true})

-- Toggle git blame
vim.keymap.set("n", "<leader>gb", ":lua require('utils.git').toggle_blame()<CR>", {noremap = true})

-- Find and replace under cursor
vim.keymap.set("n", "<leader>r", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", {noremap = true})
