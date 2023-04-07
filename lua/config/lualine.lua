require("lualine").setup({
	options = {
		icons_enabled = false,
		section_separators = "", component_separators = "|",
	},
	sections = {
		-- left
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },

		-- right
		lualine_x = { "g:zoom#statustext", "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" }
	},
	extensions = { "quickfix", "fugitive", "fzf" },
})
