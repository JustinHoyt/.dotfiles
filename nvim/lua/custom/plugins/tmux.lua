return {
	"aserowy/tmux.nvim",
	config = function()
		return require("tmux").setup({
			copy_sync = {
				enable = false,
			},
			resize = {
				enable_default_keybindings = true,
				resize_step_x = 50,
				resize_step_y = 10,
			},
		})
	end,
}
