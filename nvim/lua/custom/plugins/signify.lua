return {
	"mhinz/vim-signify",
	config = function()
		-- Optional: Configure to look more like gitsigns default
		vim.g.signify_sign_add = "│"
		vim.g.signify_sign_delete = "_"
		vim.g.signify_sign_delete_first_line = "‾"
		vim.g.signify_sign_change = "│"
	end,
}
