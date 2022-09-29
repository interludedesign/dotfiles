require'nvim-treesitter.configs'.setup {
	ensure_installed = { "ruby", "lua", "markdown", "json" },
	sync_install = false,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},

	endwise = {
		enable = true,
	},

	textobjects = {
		select = {
			enable = true,

			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["im"] = { query = "@method", desc = "Select block inner" },
				["am"] = { query = "@block.outer", desc = "Select block outer" },
				["ic"] = { query = "@class.inner", desc = "Select class inner" },
				["ac"] = { query = "@class.outer", desc = "Select class outer" },
				["if"] = { query = "@function.inner", desc = "Select function inner" },
				["af"] = { query = "@function.outer", desc = "Select function outer" },
			},
			-- You can choose the select mode (default is charwise 'v')
			selection_modes = {
				-- ['@parameter.outer'] = 'v', -- charwise
				-- ['@function.outer'] = 'V', -- linewise
				-- ['@class.outer'] = '<c-v>', -- blockwise
			},
			-- If you set this to `true` (default is `false`) then any textobject is
			-- extended to include preceding xor succeeding whitespace. Succeeding
			-- whitespace has priority in order to act similarly to eg the built-in
			-- `ap`.
			include_surrounding_whitespace = false,
		},
	},
}
