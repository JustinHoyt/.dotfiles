return {
	"Wansmer/treesj",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("treesj").setup({
			use_default_keymaps = false,
			max_join_length = 1000,
		})

		vim.keymap.set("n", "<CR>", function()
			require("treesj").toggle()
		end)
		vim.keymap.set("n", "<leader>gs", function()
			require("treesj").toggle({ split = { recursive = true } })
		end)
	end,
}
