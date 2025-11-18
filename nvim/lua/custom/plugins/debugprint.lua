return {
	"andrewferrier/debugprint.nvim",
	opts = {},
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	version = "*",
	config = function()
		require("debugprint").setup({})

		vim.keymap.set("v", "gd", function()
			return require("debugprint").debugprint({ variable = true })
		end, { expr = true })
		vim.keymap.set("n", "yd", function()
			return require("debugprint").debugprint({ motion = true })
		end, { expr = true })
	end,
}
