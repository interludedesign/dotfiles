require('telescope').load_extension('fzf')
local telescope = require('telescope.builtin')

local search_hidden = false
local additional_args = nil

if (require('chris.utils').buf_name_contains("dotfiles") == true) then
	search_hidden = true

	-- Passes arguments to ripgrep
	additional_args = function()
		return {"--hidden"}
	end
end

vim.keymap.set("n", "<C-f>", function()
	telescope.find_files{hidden = search_hidden}
end, {noremap = true})

vim.keymap.set("n", "<leader>fg", function()
	telescope.live_grep{additional_args = additional_args, glob_pattern = "!.git/*"}
end, {noremap = true})

vim.keymap.set("n", "<leader>fj", function()
	telescope.grep_string{}
end, {noremap = true})

vim.keymap.set("n", "<leader>fr", function()
	telescope.resume{}
end, {noremap = true})

vim.keymap.set("n", "<leader>ff", function()
	telescope.find_files{}
end, {noremap = true})

vim.keymap.set("n", "<leader>fb", function()
	telescope.buffers{}
end, {noremap = true})

vim.keymap.set("n", "<leader>fh", function()
	telescope.help_tags{}
end, {noremap = true})

vim.keymap.set("n", "<leader>fq", function()
	telescope.quickfix{}
end, {noremap = true})

vim.keymap.set("n", "<leader>fk", function()
	telescope.git_files{}
end, {noremap = true})

vim.keymap.set("n", "<leader>fc", function()
	telescope.commands{}
end, {noremap = true})

vim.keymap.set("n", "<leader>fi", function()
	telescope.keymaps{}
end, {noremap = true})

vim.keymap.set("n", "<leader>gl", function()
	telescope.git_commits{}
end, {noremap = true})

vim.keymap.set("n", "<leader>fv", function()
	require('chris.telescope').search_dotfiles()
end, {noremap = true})

vim.keymap.set("n", "<leader>fd", function()
	require('chris.telescope').search_docs()
end, {noremap = true})

vim.keymap.set("n", "<leader>fD", function()
	require('chris.telescope').search_docs(true)
end, {noremap = true})

vim.keymap.set("n", "<leader>fo", function()
	telescope.vim_options{}
end, {noremap = true})
