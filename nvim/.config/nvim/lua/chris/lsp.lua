local setup = function(_, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap=true, silent=true, buffer=bufnr }

	-- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	-- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	-- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	-- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)

	-- vim.keymap.set('n', '<leader>wl', function()
	-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, bufopts)

	-- vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
	-- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
	-- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	-- vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
end

-- Ruby Language Server
require'lspconfig'.solargraph.setup{
	on_attach = setup,
	filetypes = { "ruby", "eruby" }
}

-- Javascript Language Server
require'lspconfig'.tsserver.setup{
	on_attach = setup
}

-- Lua Language Server
require'lspconfig'.sumneko_lua.setup{
	on_attach = setup,
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' }
			}
		}
	}
}
