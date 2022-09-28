require("tokyonight").setup({
	style = "night",
	transparent = true,

	-- # Hello there
	on_colors = function(colors)
		colors.comment = '#7a9fc4'
		colors.fg_gutter = '#4a75a1'
	end
})

vim.cmd[[colorscheme tokyonight]]

local colors = require('tokyonight.colors').setup()

local hl = function(thing, opts)
	vim.api.nvim_set_hl(0, thing, opts)
end

hl("Folded", {
	guibg = colors.bg_light,
	-- guifg = colors.bg_dark,
})
