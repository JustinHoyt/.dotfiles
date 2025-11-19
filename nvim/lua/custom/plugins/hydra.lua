return {
	"anuvyklack/hydra.nvim",
	config = function()
		local Hydra = require("hydra")

		AngularSwitch = Hydra({
			name = "Angular Switch",
			mode = "n",
			heads = {
				{ "q", "<cmd>edit `angular_switch % scss`<CR>", { exit = true } },
				{ "w", "<cmd>edit `angular_switch % html`<CR>", { exit = true } },
				{ "e", "<cmd>edit `angular_switch % ts`<CR>", { exit = true } },
				{ "r", "<cmd>edit `angular_switch % test`<CR>", { exit = true } },
				{ "t", "<cmd>edit `angular_switch % harness`<CR>", { exit = true } },
				{ "-", "<cmd>edit `angular_switch % build`<CR>", { exit = true } },
				{ "n", '<cmd>lua require("harpoon.ui").nav_next()<CR>', {} },
				{ "p", '<cmd>lua require("harpoon.ui").nav_prev()<CR>', {} },
				{ "o", "<C-o>", {} },
				{ "i", "<C-i>", {} },
				{ "z", [['z]], { exit = true } },
				{ "x", [['x]], { exit = true } },
				{ "c", [['c]], { exit = true } },
				{ "v", [['v]], { exit = true } },
				{ "a", '<cmd>lua require("harpoon.ui").nav_file(1)<CR>', {} },
				{ "s", '<cmd>lua require("harpoon.ui").nav_file(2)<CR>', {} },
				{ "d", '<cmd>lua require("harpoon.ui").nav_file(3)<CR>', {} },
				{ "f", '<cmd>lua require("harpoon.ui").nav_file(4)<CR>', {} },
				{ "g", '<cmd>lua require("harpoon.ui").nav_file(5)<CR>', {} },
				{ "h", '<cmd>lua require("harpoon.ui").nav_file(6)<CR>', {} },
				{ "j", '<cmd>lua require("harpoon.ui").nav_file(7)<CR>', {} },
				{ "k", '<cmd>lua require("harpoon.ui").nav_file(8)<CR>', {} },
				{ "l", '<cmd>lua require("harpoon.ui").nav_file(9)<CR>', {} },
				{ ";", '<cmd>lua require("harpoon.ui").nav_file(10)<CR>', {} },
				{ "<ESC>", nil, { nowait = true, exit = true } },
				{ "<BS>", nil, { nowait = true, exit = true } },
			},
		})

		vim.keymap.set(
			"n",
			",q",
			"<cmd>edit `angular_switch % scss`<CR>",
			{ desc = "Angular switch to css file", silent = true }
		)
		vim.keymap.set(
			"n",
			",w",
			"<cmd>edit `angular_switch % html`<CR>",
			{ desc = "Angular switch to html file", silent = true }
		)
		vim.keymap.set(
			"n",
			",e",
			"<cmd>edit `angular_switch % ts`<CR>",
			{ desc = "Angular switch to component file", silent = true }
		)
		vim.keymap.set(
			"n",
			",r",
			"<cmd>edit `angular_switch % test`<CR>",
			{ desc = "Angular switch to test file", silent = true }
		)
		vim.keymap.set(
			"n",
			",t",
			"<cmd>edit `angular_switch % harness`<CR>",
			{ desc = "Angular switch to harness file", silent = true }
		)
		vim.keymap.set(
			"n",
			",-",
			"<cmd>edit `angular_switch % build`<CR>",
			{ desc = "Angular switch to BUILD file", silent = true }
		)
		vim.keymap.set(
			"n",
			",m",
			'<cmd>lua require("harpoon.mark").add_file()<CR>',
			{ desc = "[H]arpoon [C]reate mark", silent = true }
		)
		vim.keymap.set(
			"n",
			",n",
			'<cmd>lua require("harpoon.ui").nav_next()<CR><cmd>lua require("hydra").activate(AngularSwitch)<CR>',
			{ desc = "[H]arpoon [C]reate mark", silent = true }
		)
		vim.keymap.set(
			"n",
			",p",
			'<cmd>lua require("harpoon.ui").nav_prev()<CR><cmd>lua require("hydra").activate(AngularSwitch)<CR>',
			{ desc = "[H]arpoon [C]reate mark", silent = true }
		)
		vim.keymap.set(
			"n",
			",,",
			'<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>',
			{ desc = "[H]arpoon [M]enu", silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			",a",
			'<cmd>lua require("harpoon.ui").nav_file(1)<CR><cmd>lua require("hydra").activate(AngularSwitch)<CR>',
			{ silent = true, noremap = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			",s",
			'<cmd>lua require("harpoon.ui").nav_file(2)<CR><cmd>lua require("hydra").activate(AngularSwitch)<CR>',
			{ silent = true, noremap = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			",d",
			'<cmd>lua require("harpoon.ui").nav_file(3)<CR><cmd>lua require("hydra").activate(AngularSwitch)<CR>',
			{ silent = true, noremap = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			",f",
			'<cmd>lua require("harpoon.ui").nav_file(4)<CR><cmd>lua require("hydra").activate(AngularSwitch)<CR>',
			{ silent = true, noremap = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			",g",
			'<cmd>lua require("harpoon.ui").nav_file(5)<CR><cmd>lua require("hydra").activate(AngularSwitch)<CR>',
			{ silent = true, noremap = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			",h",
			'<cmd>lua require("harpoon.ui").nav_file(6)<CR><cmd>lua require("hydra").activate(AngularSwitch)<CR>',
			{ silent = true, noremap = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			",j",
			'<cmd>lua require("harpoon.ui").nav_file(7)<CR><cmd>lua require("hydra").activate(AngularSwitch)<CR>',
			{ silent = true, noremap = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			",k",
			'<cmd>lua require("harpoon.ui").nav_file(8)<CR><cmd>lua require("hydra").activate(AngularSwitch)<CR>',
			{ silent = true, noremap = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			",l",
			'<cmd>lua require("harpoon.ui").nav_file(9)<CR><cmd>lua require("hydra").activate(AngularSwitch)<CR>',
			{ silent = true, noremap = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			",;",
			'<cmd>lua require("harpoon.ui").nav_file(10)<CR><cmd>lua require("hydra").activate(AngularSwitch)<CR>',
			{ silent = true, noremap = true }
		)
		vim.api.nvim_set_keymap("n", "<leader>,z", "<cmd>mark z<CR>", { silent = true, noremap = true })
		vim.api.nvim_set_keymap("n", "<leader>,x", "<cmd>mark x<CR>", { silent = true, noremap = true })
		vim.api.nvim_set_keymap("n", "<leader>,c", "<cmd>mark c<CR>", { silent = true, noremap = true })
		vim.api.nvim_set_keymap("n", "<leader>,v", "<cmd>mark v<CR>", { silent = true, noremap = true })
		vim.api.nvim_set_keymap("n", "<leader>,b", "<cmd>mark b<CR>", { silent = true, noremap = true })
		vim.api.nvim_set_keymap("n", ",z", [['z]], { silent = true, noremap = true })
		vim.api.nvim_set_keymap("n", ",x", [['x]], { silent = true, noremap = true })
		vim.api.nvim_set_keymap("n", ",c", [['c]], { silent = true, noremap = true })
		vim.api.nvim_set_keymap("n", ",v", [['v]], { silent = true, noremap = true })
		vim.api.nvim_set_keymap("n", ",b", [['b]], { silent = true, noremap = true })

		MyScroll = Hydra({
			name = "Scroll",
			mode = "n",
			heads = {
				{ "u", "<C-u>", { private = true } },
				{ "d", "<C-d>", { private = true } },
				{ "q", "<CMD>q!<CR>", { private = true } },
				{ "e", "<C-e>", { private = true } },
				{ "y", "<C-y>", { private = true } },
				{ "g", "gg", { private = true } },
				{ "G", "G", { private = true } },
				{ "<C-o>", "<C-o>", { private = true } },
				{ "<C-i>", "<C-i>", { private = true } },
				{ "<ESC>", nil, { nowait = true, exit = true } },
				{ "<BS>", nil, { nowait = true, exit = true } },
			},
		})
		vim.api.nvim_set_keymap(
			"n",
			"<C-u>",
			'<C-u><cmd>lua require("hydra").activate(MyScroll)<CR>',
			{ silent = true, noremap = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<C-d>",
			'<C-d><cmd>lua require("hydra").activate(MyScroll)<CR>',
			{ silent = true, noremap = true }
		)

		MySave = Hydra({
			name = "Save",
			config = {
				hint = false,
				timeout = 200,
			},
			mode = "n",
			heads = {
				{ "j", "<cmd>w<CR>", { private = true } },
				{ "k", "<cmd>q!<CR>", { private = true } },
				{ "f", "<cmd>q!<CR>", { private = true } },
			},
		})
		vim.api.nvim_set_keymap(
			"n",
			"<leader>j",
			'<cmd>w<CR><cmd>lua require("hydra").activate(MySave)<CR>',
			{ silent = true, noremap = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>k",
			'<cmd>q<CR><cmd>lua require("hydra").activate(MySave)<CR>',
			{ silent = true, noremap = true }
		)
		vim.api.nvim_set_keymap("n", "<leader>n", "<cmd>q!<CR>", { silent = true, noremap = true })

		Hydra({
			name = "Unimpaired Next",
			body = "]",
			mode = "n",
			heads = {
				{ "h", "<Plug>(signify-next-hunk)", { desc = "next signify diff" } },
				{ "n", "<Plug>(signify-next-hunk)", { desc = "next signify diff", private = true } },
				{ "p", "<Plug>(signify-prev-hunk)", { desc = "prev signify diff", private = true } },
				{ "d", "<Plug>(SignifyHunkDiff)", { desc = "prev signify diff", private = true } },
				{ "u", "<Plug>(SignifyHunkUndo)", { desc = "prev signify diff", private = true } },
				{ "<ESC>", nil, { nowait = true, exit = true } },
				{ "<BS>", nil, { nowait = true, exit = true } },
			},
		})
		Hydra({
			name = "Unimpaired Prev",
			body = "[",
			mode = "n",
			heads = {
				{ "h", "<Plug>(signify-prev-hunk)", { desc = "prev signify diff" } },
				{ "n", "<Plug>(signify-next-hunk)", { desc = "next signify diff", private = true } },
				{ "p", "<Plug>(signify-prev-hunk)", { desc = "prev signify diff", private = true } },
				{ "d", "<Plug>(SignifyHunkDiff)", { desc = "prev signify diff", private = true } },
				{ "u", "<Plug>(SignifyHunkUndo)", { desc = "prev signify diff", private = true } },
				{ "<ESC>", nil, { nowait = true, exit = true } },
				{ "<BS>", nil, { nowait = true, exit = true } },
			},
		})

		Hydra({
			name = "Unimpaired Next",
			body = "]",
			mode = "n",
			heads = {
				{ "d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "next diagnostic" } },
				{ "n", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "next diagnostic", private = true } },
				{ "p", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "prev diagnostic", private = true } },
				{ "<ESC>", nil, { nowait = true, exit = true } },
				{ "<BS>", nil, { nowait = true, exit = true } },
			},
		})
		Hydra({
			name = "Unimpaired Prev",
			body = "[",
			mode = "n",
			heads = {
				{ "d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "prev diagnostic" } },
				{ "n", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "next diagnostic", private = true } },
				{ "p", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "prev diagnostic", private = true } },
				{ "<ESC>", nil, { nowait = true, exit = true } },
				{ "<BS>", nil, { nowait = true, exit = true } },
			},
		})

		Hydra({
			name = "Unimpaired Next",
			body = "]",
			mode = "n",
			heads = {
				{ "s", "]s", { desc = "next misspelled line" } },
				{ "n", "]s", { desc = "next misspelled line", private = true } },
				{ "p", "[s", { desc = "prev misspelled line", private = true } },
				{ "<ESC>", nil, { nowait = true, exit = true } },
				{ "<BS>", nil, { nowait = true, exit = true } },
			},
		})
		Hydra({
			name = "Unimpaired Prev",
			body = "[",
			mode = "n",
			heads = {
				{ "s", "[s", { desc = "prev misspelled line" } },
				{ "n", "]s", { desc = "next misspelled line", private = true } },
				{ "p", "[s", { desc = "prev misspelled line", private = true } },
				{ "<ESC>", nil, { nowait = true, exit = true } },
				{ "<BS>", nil, { nowait = true, exit = true } },
			},
		})

		Hydra({
			name = "Unimpaired Next",
			body = "]",
			mode = "n",
			heads = {
				{ "f", "]m", { desc = "next function" } },
				{ "n", "]m", { desc = "next function", private = true } },
				{ "p", "[m", { desc = "prev function", private = true } },
				{ "<ESC>", nil, { nowait = true, exit = true } },
				{ "<BS>", nil, { nowait = true, exit = true } },
			},
		})
		Hydra({
			name = "Unimpaired Prev",
			body = "[",
			mode = "n",
			heads = {
				{ "f", "[m", { desc = "prev function" } },
				{ "n", "]m", { desc = "next function", private = true } },
				{ "p", "[m", { desc = "prev function", private = true } },
				{ "<ESC>", nil, { nowait = true, exit = true } },
				{ "<BS>", nil, { nowait = true, exit = true } },
			},
		})

		Hydra({
			name = "Unimpaired Next",
			body = "]",
			mode = "n",
			heads = {
				{ "c", [[/<<<<<CR>]], { desc = "next conflict" } },
				{ "n", [[/<<<<<CR>]], { desc = "next conflict", private = true } },
				{ "p", [[?<<<<<CR>]], { desc = "prev conflict", private = true } },
				{ "<ESC>", nil, { nowait = true, exit = true } },
				{ "<BS>", nil, { nowait = true, exit = true } },
			},
		})
		Hydra({
			name = "Unimpaired Prev",
			body = "[",
			mode = "n",
			heads = {
				{ "c", [[?<<<<<CR>]], { desc = "prev conflict" } },
				{ "n", [[/<<<<<CR>]], { desc = "next conflict", private = true } },
				{ "p", [[?<<<<<CR>]], { desc = "prev conflict", private = true } },
				{ "<ESC>", nil, { nowait = true, exit = true } },
				{ "<BS>", nil, { nowait = true, exit = true } },
			},
		})

		MyMoveChar = Hydra({
			name = "Move char",
			mode = "n",
			body = "g",
			heads = {
				{ "<LEFT>", "xhP", { desc = "move char left" } },
				{ "<UP>", "xkPlxjhPk", { desc = "move char up" } },
				{ "<DOWN>", "xjPlxhkPj", { desc = "move char down" } },
				{ "<RIGHT>", "xp", { desc = "move char right" } },
				{ "y", "h" },
				{ "u", "j" },
				{ "i", "k" },
				{ "o", "l" },
				{ "h", "h" },
				{ "j", "j" },
				{ "k", "k" },
				{ "l", "l" },
				{ "b", "b" },
				{ "w", "w" },
				{ "^", "^" },
				{ "$", "$" },
				{ "<ESC>", nil, { nowait = true, exit = true } },
				{ "<BS>", nil, { nowait = true, exit = true } },
			},
		})
		vim.api.nvim_set_keymap(
			"n",
			"g<LEFT>",
			[[xhP<cmd>lua require("hydra").activate(MyMoveChar)<CR>]],
			{ silent = true, noremap = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"g<UP>",
			[[xkPlxjhPk<cmd>lua require("hydra").activate(MyMoveChar)<CR>]],
			{ silent = true, noremap = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"g<DOWN>",
			[[xjPlxkhPj<cmd>lua require("hydra").activate(MyMoveChar)<CR>]],
			{ silent = true, noremap = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"g<RIGHT>",
			[[xp<cmd>lua require("hydra").activate(MyMoveChar)<CR>]],
			{ silent = true, noremap = true }
		)
	end,
}
