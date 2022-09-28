local azure_root_url = os.getenv("AZURE_ROOT_URL")
local azure_repo_list = os.getenv("AZURE_REPO_LIST")
local split = require('chris.utils').split

require("azureutils").setup(
	azure_root_url,
	split(azure_repo_list, ",")
)

-- Open in browser
vim.api.nvim_set_keymap("n", "<leader><leader>c", ":lua require('azureutils').open_file_in_azure()<CR>", {noremap = true})
