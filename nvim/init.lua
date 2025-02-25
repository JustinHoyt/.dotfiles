vim.g.mapleader = " "
--  Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.maplocalleader = " "

vim.o.background = "dark"

vim.opt.cursorline = true

vim.bo.tabstop = 4

-- Install package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	-- Git related plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",

	--  The configuration is done below. Search for lspconfig to find it below.
	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"SmiteshP/nvim-navbuddy",
				dependencies = {
					"SmiteshP/nvim-navic",
					"MunifTanjim/nui.nvim",
				},
				opts = { lsp = { auto_attach = true } },
			},
			-- Automatically install LSPs to stdpath for neovim
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim",       tag = "legacy", opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			"folke/neodev.nvim",
		},
	},

	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			-- Adds a number of user-friendly snippets
			"rafamadriz/friendly-snippets",
		},
	},

	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",

			-- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp",
		},
	},

	-- Useful plugin to show you pending keybinds.
	{ "folke/which-key.nvim",                opts = {} },
	{
		-- Theme inspired by Atom
		"navarasu/onedark.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("onedark")
		end,
	},

	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

	-- Fuzzy Finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- Fuzzy Finder Algorithm which requires local dependencies to be built.
	-- Only load if `make` is available. Make sure you have the system
	-- requirements installed.
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		-- NOTE: If you are having trouble with this installation,
		--       refer to the README for telescope-fzf-native for more instructions.
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},

	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},

	-- Smart quote and paren pairing
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},

	-- Overwrites 's' and 'r' keys to act as jump motions
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = { modes = { char = { enabled = false } } },
		-- stylua: ignore
		keys = {
			{ "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
			{ "S",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
			{ "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
			{ "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
		},
	},

	-- File system plugin that allows editing and manipulating files in buffers
	{
		"stevearc/oil.nvim",
		opts = {
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-s>"] = "actions.select_vsplit",
				["<C-x>"] = "actions.select_split",
				["<C-h>"] = false,
				["<C-t>"] = "actions.select_tab",
				["<C-p>"] = "actions.preview",
				["<C-c>"] = "actions.close",
				["<C-l>"] = false,
				["<C-r>"] = "actions.refresh",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["(s"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
			},
		},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- underline the word your cursor is on
	{ "echasnovski/mini.cursorword", version = "*", opts = {} },

	{
		"echasnovski/mini.move",
		version = "*",
		config = {
			mappings = {
				-- Move current block in Visual mode
				left = "<LEFT>",
				down = "<DOWN>",
				up = "<UP>",
				right = "<RIGHT>",

				-- Move current line in Normal mode
				line_left = "<LEFT>",
				line_right = "<RIGHT>",
				line_down = "<DOWN>",
				line_up = "<UP>",
			},
		},
	},

	{ "echasnovski/mini.statusline", version = "*" },

	{ "echasnovski/mini.comment",    version = "*", opts = {} },

	{
		"echasnovski/mini.operators",
		version = "*",
		opts = {
			sort = { prefix = "gS" },
			multiply = { prefix = "m" },
			replace = { prefix = "r" },
		},
	},

	{
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
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = { max_lines = 4 },
	},

	{
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
	},

	{
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
	},

	{
		"cseickel/diagnostic-window.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		config = function()
			vim.keymap.set("n", "<Space>e", ":DiagWindowShow<CR>", { silent = true })
		end,
	},

	{
		"mhinz/vim-signify",
		config = function()
			vim.keymap.set("n", "<Space>hd", ":SignifyHunkDiff<CR>", { silent = true })
			vim.keymap.set("n", "<Space>hu", ":SignifyHunkUndo<CR>", { silent = true })
			vim.keymap.set("n", "<Space>hf", ":SignifyFold<CR>", { silent = true })
			vim.keymap.set("n", "<Space>ha", ":SignifyDiff<CR>", { silent = true })
			vim.keymap.set("n", "<Space>hh", ":SignifyToggleHighLight<CR>", { silent = true })
		end,
	}, -- Git and mercurial sign column

	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("refactoring").setup({})

			vim.keymap.set("x", "<leader>re", ":Refactor extract ", { noremap = true })
			vim.keymap.set("x", "<leader>rE", ":Refactor extract_to_file ", { noremap = true })
			vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ", { noremap = true })
			vim.keymap.set({ "n", "x" }, "<leader>rI", ":Refactor inline_var", { noremap = true })
			vim.keymap.set("n", "<leader>ri", ":Refactor inline_func", { noremap = true })
			vim.keymap.set("n", "<leader>rb", ":Refactor extract_block", { noremap = true })
			vim.keymap.set("n", "<leader>rB", ":Refactor extract_block_to_file", { noremap = true })
		end,
	},

	{
		"debugloop/telescope-undo.nvim",
		keys = {
			{ -- lazy style key map
				"<leader>su",
				"<cmd>Telescope undo<cr>",
				desc = "undo history",
			},
		},
		opts = {
			extensions = {
				undo = {
					mappings = {
						i = {
							["<C-a>"] = function(bufnr)
								return require("telescope-undo.actions").yank_additions(bufnr)
							end,
							["<C-d>"] = function(bufnr)
								return require("telescope-undo.actions").yank_deletions(bufnr)
							end,
							["<C-r>"] = function(bufnr)
								return require("telescope-undo.actions").restore(bufnr)
							end,
						},
						n = {
							["y"] = function(bufnr)
								return require("telescope-undo.actions").yank_additions(bufnr)
							end,
							["Y"] = function(bufnr)
								return require("telescope-undo.actions").yank_deletions(bufnr)
							end,
							["u"] = function(bufnr)
								return require("telescope-undo.actions").restore(bufnr)
							end,
						},
					},
				},
			},
		},
		config = function(_, opts)
			-- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
			-- configs for us. We won't use data, as everything is in it's own namespace (telescope
			-- defaults, as well as each extension).
			require("telescope").setup(opts)
			require("telescope").load_extension("undo")
		end,
	},

	{
		"johmsalas/text-case.nvim",
		config = function()
			require("textcase").setup({})
		end,
	},

	{
		"Gelio/cmp-natdat",
		config = function()
			require("cmp_natdat").setup({
				cmp_kind_text = "NatDat",
			})
		end,
	},

	{
		"hrsh7th/cmp-calc",
		config = function()
			require("cmp").setup({
				sources = {
					{ name = "calc" },
				},
			})
		end,
	},

	{
		"FelipeLema/cmp-async-path",
		config = function()
			require("cmp").setup({
				sources = {
					{ name = "async_path" },
				},
			})
		end,
	},

	{
		"mtoohey31/cmp-fish",
		ft = "fish",
		config = function()
			require("cmp").setup({
				sources = {
					{ name = "fish" },
				},
			})
		end,
	},

	{
		"mhartington/formatter.nvim",
		config = function()
			require("formatter").setup({
				logging = true,
				log_level = vim.log.levels.WARN,
				filetype = {
					markdown = {
						require("formatter.filetypes.markdown").denofmt,
					},
					lua = {
						require("formatter.filetypes.lua").stylua,
					},
					fish = {
						require("formatter.filetypes.fish").fishindent,
					},
					["*"] = {
						require("formatter.filetypes.any").remove_trailing_whitespace,
					},
				},
			})
			vim.cmd([[
        augroup FormatAutogroup
        autocmd!
        autocmd BufWritePost * FormatWrite
        augroup END
        ]])
		end,
	},

	"ray-x/guihua.lua", -- recommended if need floating window support
	"ray-x/go.nvim",
	"nickeb96/fish.vim",
	"mg979/vim-visual-multi", -- Multicursor mode
	"tpope/vim-surround",    -- Surround text-objects with pairs like () or ''
	"tpope/vim-repeat",
	"ThePrimeagen/harpoon",  -- Enhance marks
	"jghauser/mkdir.nvim",
	"ojroques/nvim-osc52",
	"JustinHoyt/vim-abolish",
	"anuvyklack/hydra.nvim",
	"mbbill/undotree",
	"arthurxavierx/vim-caser",
}

if vim.loop.fs_stat(vim.fn.stdpath("config") .. "/lua/google-plugins.lua") then
	table.insert(plugins, { import = "google-plugins" })
end

require("lazy").setup(plugins, {})

-- [[ Toggle background for light and dark mode ]]
function _G.toggle_background()
	if vim.o.background == "dark" then
		vim.o.background = "light"
	else
		vim.o.background = "dark"
	end
end

-- [[ Setting options ]]

-- Set highlight on search
vim.o.hlsearch = false

vim.o.hidden = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Sync with system clipboard
vim.o.clipboard = "unnamedplus"

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.relativenumber = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

delete_swap = function()
	local filename = vim.fn.substitute(vim.fn.expand("%:p"), "/", "%", "g")

	local swapdir = vim.o.directory
	local swapfile = vim.fn.fnamemodify(swapdir, ":p") .. filename .. ".swp"

	if vim.fn.filereadable(swapfile) == 1 then
		vim.fn.delete(swapfile)
		vim.cmd('echom "Deleted swapfile: ' .. swapfile .. '"')
	else
		vim.cmd('echom "No swapfile found for current file"')
		vim.cmd('echom "Swap file: ' .. swapfile .. '"')
	end
end

-- Format markdown lines to uppercase first character and add a period to the end.
vim.keymap.set(
	"n",
	"<leader>=",
	[[:s/\v[a-z]/\U&/e<CR>:s/\v[^\.]$/&./e<CR>:s/\v<i>/I/ge<CR>:s/\v\. [a-z]/\U&/ge<CR>]],
	{ noremap = true, silent = true }
)
vim.keymap.set(
	"v",
	"<leader>=",
	[[:s/\v[a-z]/\U&/e<CR>:'<,'>s/\v[^\.]$/&./e<CR>:'<,'>s/\v<i>/I/ge<CR>:'<,'>s/\v\. [a-z]/\U&/ge<CR>]],
	{ noremap = true, silent = true }
)

vim.keymap.set("n", "Q", "@q")
vim.keymap.set("v", "Q", "@q")
vim.keymap.set("n", "qw", "qw#*")
vim.keymap.set("n", "<C-q>", "#*@wn")
vim.keymap.set("v", "<C-q>", "@w")

-- Delete current file's swap file
vim.keymap.set("n", "<leader>%", ":lua delete_swap()<CR>", { noremap = true, silent = true })

-- Replay the last ex command over the current visual selection
vim.keymap.set("v", ".", ":<UP><CR>")

-- [[ NavBuddy ]]
vim.keymap.set("n", "<leader>b", ':lua require("nvim-navbuddy").open()<CR>', { noremap = true })

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>scs", require("telescope.builtin").commands, { desc = "[S]earch [C]ommands" })
vim.keymap.set(
	"n",
	"<leader>sch",
	require("telescope.builtin").command_history,
	{ desc = "[S]earch [C]ommand [H]istory" }
)
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sj", require("telescope.builtin").jumplist, { desc = "[S]earch [J]umplist" })
vim.keymap.set("n", "<leader>sk", require("telescope.builtin").keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sm", require("telescope.builtin").man_pages, { desc = "[S]earch [M]an pages" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("v", "<leader>s", require("telescope.builtin").grep_string, { desc = "[S]earch" })
vim.keymap.set("n", "<leader>sb", "<CMD>Telescope live_grep search_dirs=%:h<CR>", { desc = "[S]earch [B]uffer's Dir" })

-- telescope LSP commands
vim.keymap.set(
	"n",
	"<leader>lci",
	require("telescope.builtin").lsp_incoming_calls,
	{ desc = "[L]sp [C]alls [I]ncoming" }
)
vim.keymap.set(
	"n",
	"<leader>lco",
	require("telescope.builtin").lsp_outgoing_calls,
	{ desc = "[L]sp [C]alls [O]utgoing" }
)
vim.keymap.set("n", "<leader>ld", require("telescope.builtin").lsp_definitions, { desc = "[L]sp [D]efinitions" })
vim.keymap.set(
	"n",
	"<leader>li",
	require("telescope.builtin").lsp_implementations,
	{ desc = "[L]sp [I]mplementations" }
)
vim.keymap.set("n", "<leader>lr", require("telescope.builtin").lsp_references, { desc = "[L]sp [R]eferences" })
vim.keymap.set(
	"n",
	"<leader>lt",
	require("telescope.builtin").lsp_type_definitions,
	{ desc = "[L]sp [T]ype Definitions" }
)
vim.keymap.set(
	"n",
	"<leader>lwd",
	require("telescope.builtin").lsp_dynamic_workspace_symbols,
	{ desc = "[L]sp [W]orkspace [D]ynamic Symbols" }
)
vim.keymap.set(
	"n",
	"<leader>lws",
	require("telescope.builtin").lsp_workspace_symbols,
	{ desc = "[L]sp [W]orkspace [S]ymbols" }
)

local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<S-Down>"] = actions.cycle_history_next,
				["<S-Up>"] = actions.cycle_history_prev,
			},
		},
	},
})

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require("nvim-treesitter.configs").setup({
	-- Add languages to be installed here that you want installed for treesitter
	ensure_installed = { "c", "cpp", "lua", "python", "rust", "tsx", "typescript", "vimdoc", "vim" },

	-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
	auto_install = false,

	highlight = { enable = true },
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<c-space>",
			node_incremental = "<c-space>",
			scope_incremental = "<c-s>",
			node_decremental = "<M-space>",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
	},
})

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "ge", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.

	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "[R]e[n]ame" })
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "[C]ode [A]ction" })

	vim.keymap.set(
		"n",
		"<leader>sr",
		require("telescope.builtin").lsp_references,
		{ desc = "[G]oto [R]eferences", noremap = true }
	)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "[G]oto [D]efinition" })
	vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = bufnr, desc = "[G]oto [I]mplementation" })
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Type [D]efinition" })
	vim.keymap.set(
		"n",
		"<leader>ds",
		require("telescope.builtin").lsp_document_symbols,
		{ buffer = bufnr, desc = "[D]ocument [S]ymbols" }
	)
	vim.keymap.set(
		"n",
		"<leader>ws",
		require("telescope.builtin").lsp_dynamic_workspace_symbols,
		{ buffer = bufnr, desc = "[W]orkspace [S]ymbols" }
	)

	vim.keymap.set("n", "gh", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover Documentation" })
	vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Documentation" })
	vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature Documentation" })

	-- Lesser used LSP functionality
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "[G]oto [D]eclaration" })
	vim.keymap.set(
		"n",
		"<leader>wa",
		vim.lsp.buf.add_workspace_folder,
		{ buffer = bufnr, desc = "[W]orkspace [A]dd Folder" }
	)
	vim.keymap.set(
		"n",
		"<leader>wr",
		vim.lsp.buf.remove_workspace_folder,
		{ buffer = bufnr, desc = "[W]orkspace [R]emove Folder" }
	)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, { buffer = bufnr, desc = "[W]orkspace [L]ist Folders" })

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
	-- clangd = {},
	-- gopls = {},
	-- pyright = {},
	-- rust_analyzer = {},
	-- tsserver = {},
	marksman = {},

	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}

-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
		})
	end,
})

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").load()
luasnip.config.setup({})

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete({}),
		["<C-y>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "natdat" },
		{ name = "calc" },
		{ name = "fish" },
		{ name = "async_path" },
	},
})

-- [[ vim-signify config ]]
vim.g.signify_vcs_list = { "hg", "git" }
vim.g.signify_sign_change = "*"
vim.g.signify_sign_delete = "-"

-- [[ Personal keymaps ]]

-- Open init.lua
vim.keymap.set("n", "<leader>v", ":e ~/.config/nvim/init.lua<CR>", { noremap = true, silent = true })

-- Reverse highlighted lines
vim.keymap.set("v", "<leader>rv", [[:g/^/m <C-r>=line('.') - 1<CR><CR>]], { noremap = true, silent = true })

-- Shortcut for uncommenting a commented code block
vim.keymap.set("n", "gcu", "gcgc", { noremap = true, silent = true })

-- Open a file running watcher by executing the current file as a script
vim.api.nvim_set_keymap(
	"n",
	"<leader>te",
	":bot 15sp | terminal chmod +x "
	.. vim.fn.expand("%")
	.. " && echo "
	.. vim.fn.expand("%")
	.. " | entr -c -r "
	.. vim.fn.expand("%")
	.. "<CR><C-w><C-k>",
	{ noremap = true, silent = true, desc = "[T]erminal [E]xecute file" }
)

-- Open a file running watcher by executing the current file as a fish script
vim.api.nvim_set_keymap(
	"n",
	"<leader>tf",
	":bot 15sp | terminal echo "
	.. vim.fn.expand("%")
	.. " | entr -c -r fish "
	.. vim.fn.expand("%")
	.. "<CR><C-w><C-k>",
	{ noremap = true, silent = true, desc = "[T]erminal execute [F]ish file" }
)

-- Ex command shortcuts
vim.keymap.set("n", "<leader>j", ":w<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>k", ":q<CR>", { noremap = true, silent = true })

-- Navigate between windows with Ctrl-[h|j|k|l]
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-h>", { noremap = true })
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-j>", { noremap = true })
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-k>", { noremap = true })
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-l>", { noremap = true })
vim.keymap.set("t", "<C-=>", "<C-\\><C-N><C-W><C-=>", { noremap = true })
vim.keymap.set("t", "<esc><esc>", "<C-\\><C-N>", { noremap = true })

-- Regex substitute with very magic mode shortcut
vim.keymap.set("n", "(s", [[:%s#\v#&#g<left><left><left><left>]], { noremap = true, desc = "[Y]ou [G]o [s]ubstitue" })
vim.keymap.set("v", "(s", [[:s#\v#&#g<left><left><left><left>]], { noremap = true, desc = "[Y]ou [G]o [s]ubstitue" })
vim.keymap.set("n", "(v", ":%S///g<left><left><left>", { noremap = true, desc = "[Y]ou [G]o [S]ubvert" })
vim.keymap.set("v", "(v", ":S///g<left><left><left>", { noremap = true, desc = "[Y]ou [G]o [S]ubvert" })
vim.keymap.set("n", "(/", [[/\v]], { noremap = true, desc = "[Y]ou [G]o [/]" })
vim.keymap.set(
	"n",
	"(g",
	":%g//norm <LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>",
	{ noremap = true, desc = "[Y]ou [G]o [G]lobal" }
)

vim.cmd([[
function! ReplaceAndMoveCursor()
  let cmdline = getcmdline()
  let pos = getcmdpos()

  if cmdline[pos-3:pos-2] == '*?'
    let newcmdline = cmdline[:pos-4] . '{-}' . cmdline[pos-1:]
    call setcmdpos(pos+1)
		return newcmdline
	endif
	return cmdline
endfunction
]])

-- Monday, January 22 2024
vim.keymap.set(
	"i",
	"<C-d>",
	[[<CMD>s#\v\d+-\d+-\d+#\=substitute(system('date -d "' . submatch('0') . '" +"%A, %B %d %Y"'), "\n", "", "")#<CR><ESC>A]],
	{ noremap = true }
)

-- Ex mapping to make very magic mode regex act like perl's regex by replacing perl's `*?` with `{-}` automatically
vim.api.nvim_set_keymap("c", "?", [[?<C-\>eReplaceAndMoveCursor()<CR>]], { noremap = true })

-- Paste all regex line matches to the current line
vim.keymap.set(
	"n",
	"<leader>gp",
	[[:mark z | g//t 'z<left><left><left><left><left>]],
	{ noremap = true, desc = "[G]lobal [P]ut" }
)

-- Rerun the last terminal command and come back to the editor
vim.keymap.set("n", "<leader>rp", "<ESC><C-w>ji<UP><CR><C-\\><C-N><C-w>k", { noremap = true, desc = "[R]e[p]eat" })

-- Search from current file's directory
vim.keymap.set("n", "<leader>f", ":e %:h/**/*", { noremap = true })

-- Map the function to a key combination
vim.keymap.set("n", "<leader>`", ":lua toggle_background()<CR>", { noremap = true })

vim.keymap.set("n", "<leader>o", "O<ESC>j", { noremap = true })

-- [[ nvim-osc52 ]]
local function copy(lines, _)
	require("osc52").copy(table.concat(lines, "\n"))
end

local function paste()
	return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
end

vim.g.clipboard = {
	name = "osc52",
	copy = { ["+"] = copy, ["*"] = copy },
	paste = { ["+"] = paste, ["*"] = paste },
}

-- d/D delete instead of cut
vim.keymap.set({ "n", "v" }, "d", '"_d', { noremap = true })
vim.keymap.set("n", "dd", '"_dd', { noremap = true })
vim.keymap.set("n", "D", '"_D', { noremap = true })
-- delete linewise over %
vim.keymap.set("n", "(d", [[V%"_d]], { noremap = true })

-- c/C delete instead of cut
vim.keymap.set({ "n", "v" }, "c", '"_c', { noremap = true })
vim.keymap.set("n", "cc", '"_cc', { noremap = true })
vim.keymap.set("n", "C", '"_C', { noremap = true })
-- delete linewise over %
vim.keymap.set("n", "(c", [[V%"_c]], { noremap = true })

-- x/X as cut motion
vim.keymap.set({ "n", "v" }, "x", "d", { noremap = true })
vim.keymap.set("n", "xx", "dd", { noremap = true })
vim.keymap.set("n", "X", "D", { noremap = true })
vim.keymap.set("n", "xp", '"zdl"zp', { noremap = true })
-- cut linewise over %
vim.keymap.set("n", "(x", [[V%d]], { noremap = true })

-- yank linewise over %
vim.keymap.set("n", "(y", [[V%y]], { noremap = true })

-- p deletes in visual mode
vim.keymap.set("v", "p", '"_dP', { noremap = true })

-- r replaces in normal mode
vim.keymap.set("n", "R", "r$", { noremap = true })

-- [[ Macros ]]
-- Convert github URL to a string of the user/project
vim.cmd([[let @p="^yss'$a,\<Esc>F/;ldT'=="]])

-- [[ Oil ]]
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- [[ onedark ]]
require("onedark").setup({
	-- Main options --
	style = "dark",                         -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
	transparent = true,                     -- Show/hide background
	term_colors = true,                     -- Change terminal color as per the selected theme style
	ending_tildes = false,                  -- Show the end-of-buffer tildes. By default they are hidden
	-- toggle theme style ---
	toggle_style_list = { "light", "dark" }, -- List of styles to toggle between

	-- Change code style ---
	-- Options are italic, bold, underline, none
	-- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
	code_style = {
		comments = "italic",
		keywords = "none",
		functions = "none",
		strings = "none",
		variables = "none",
	},

	-- Custom Highlights --
	colors = {},    -- Override default colors
	highlights = {}, -- Override highlight groups

	-- Plugins Config --
	diagnostics = {
		darker = true,   -- darker colors for diagnostic
		undercurl = true, -- use undercurl instead of underline for diagnostics
		background = true, -- use background color for virtual text
	},
})
require("onedark").load()

-- [[ hydra ]]
local Hydra = require("hydra")

AngularSwitch = Hydra({
	name = "Angular Switch",
	mode = "n",
	heads = {
		{ "q",     "<cmd>edit `angular_switch % scss`<CR>",           { exit = true } },
		{ "w",     "<cmd>edit `angular_switch % html`<CR>",           { exit = true } },
		{ "e",     "<cmd>edit `angular_switch % ts`<CR>",             { exit = true } },
		{ "r",     "<cmd>edit `angular_switch % test`<CR>",           { exit = true } },
		{ "t",     "<cmd>edit `angular_switch % harness`<CR>",        { exit = true } },
		{ "-",     "<cmd>edit `angular_switch % build`<CR>",          { exit = true } },
		{ "n",     '<cmd>lua require("harpoon.ui").nav_next()<CR>',   {} },
		{ "p",     '<cmd>lua require("harpoon.ui").nav_prev()<CR>',   {} },
		{ "o",     "<C-o>",                                           {} },
		{ "i",     "<C-i>",                                           {} },
		{ "z",     [['z]],                                            { exit = true } },
		{ "x",     [['x]],                                            { exit = true } },
		{ "c",     [['c]],                                            { exit = true } },
		{ "v",     [['v]],                                            { exit = true } },
		{ "a",     '<cmd>lua require("harpoon.ui").nav_file(1)<CR>',  {} },
		{ "s",     '<cmd>lua require("harpoon.ui").nav_file(2)<CR>',  {} },
		{ "d",     '<cmd>lua require("harpoon.ui").nav_file(3)<CR>',  {} },
		{ "f",     '<cmd>lua require("harpoon.ui").nav_file(4)<CR>',  {} },
		{ "g",     '<cmd>lua require("harpoon.ui").nav_file(5)<CR>',  {} },
		{ "h",     '<cmd>lua require("harpoon.ui").nav_file(6)<CR>',  {} },
		{ "j",     '<cmd>lua require("harpoon.ui").nav_file(7)<CR>',  {} },
		{ "k",     '<cmd>lua require("harpoon.ui").nav_file(8)<CR>',  {} },
		{ "l",     '<cmd>lua require("harpoon.ui").nav_file(9)<CR>',  {} },
		{ ";",     '<cmd>lua require("harpoon.ui").nav_file(10)<CR>', {} },
		{ "<ESC>", nil,                                               { nowait = true, exit = true } },
		{ "<BS>",  nil,                                               { nowait = true, exit = true } },
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
		{ "u",     "<C-u>",       { private = true } },
		{ "d",     "<C-d>",       { private = true } },
		{ "q",     "<CMD>q!<CR>", { private = true } },
		{ "e",     "<C-e>",       { private = true } },
		{ "y",     "<C-y>",       { private = true } },
		{ "g",     "gg",          { private = true } },
		{ "G",     "G",           { private = true } },
		{ "<C-o>", "<C-o>",       { private = true } },
		{ "<C-i>", "<C-i>",       { private = true } },
		{ "<ESC>", nil,           { nowait = true, exit = true } },
		{ "<BS>",  nil,           { nowait = true, exit = true } },
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
		{ "j", "<cmd>w<CR>",  { private = true } },
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
		{ "h",     "<Plug>(signify-next-hunk)", { desc = "next signify diff" } },
		{ "n",     "<Plug>(signify-next-hunk)", { desc = "next signify diff", private = true } },
		{ "p",     "<Plug>(signify-prev-hunk)", { desc = "prev signify diff", private = true } },
		{ "d",     "<Plug>(SignifyHunkDiff)",   { desc = "prev signify diff", private = true } },
		{ "u",     "<Plug>(SignifyHunkUndo)",   { desc = "prev signify diff", private = true } },
		{ "<ESC>", nil,                         { nowait = true, exit = true } },
		{ "<BS>",  nil,                         { nowait = true, exit = true } },
	},
})
Hydra({
	name = "Unimpaired Prev",
	body = "[",
	mode = "n",
	heads = {
		{ "h",     "<Plug>(signify-prev-hunk)", { desc = "prev signify diff" } },
		{ "n",     "<Plug>(signify-next-hunk)", { desc = "next signify diff", private = true } },
		{ "p",     "<Plug>(signify-prev-hunk)", { desc = "prev signify diff", private = true } },
		{ "d",     "<Plug>(SignifyHunkDiff)",   { desc = "prev signify diff", private = true } },
		{ "u",     "<Plug>(SignifyHunkUndo)",   { desc = "prev signify diff", private = true } },
		{ "<ESC>", nil,                         { nowait = true, exit = true } },
		{ "<BS>",  nil,                         { nowait = true, exit = true } },
	},
})

Hydra({
	name = "Unimpaired Next",
	body = "]",
	mode = "n",
	heads = {
		{ "d",     "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "next diagnostic" } },
		{ "n",     "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "next diagnostic", private = true } },
		{ "p",     "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "prev diagnostic", private = true } },
		{ "<ESC>", nil,                                       { nowait = true, exit = true } },
		{ "<BS>",  nil,                                       { nowait = true, exit = true } },
	},
})
Hydra({
	name = "Unimpaired Prev",
	body = "[",
	mode = "n",
	heads = {
		{ "d",     "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "prev diagnostic" } },
		{ "n",     "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "next diagnostic", private = true } },
		{ "p",     "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "prev diagnostic", private = true } },
		{ "<ESC>", nil,                                       { nowait = true, exit = true } },
		{ "<BS>",  nil,                                       { nowait = true, exit = true } },
	},
})

Hydra({
	name = "Unimpaired Next",
	body = "]",
	mode = "n",
	heads = {
		{ "s",     "]s", { desc = "next misspelled line" } },
		{ "n",     "]s", { desc = "next misspelled line", private = true } },
		{ "p",     "[s", { desc = "prev misspelled line", private = true } },
		{ "<ESC>", nil,  { nowait = true, exit = true } },
		{ "<BS>",  nil,  { nowait = true, exit = true } },
	},
})
Hydra({
	name = "Unimpaired Prev",
	body = "[",
	mode = "n",
	heads = {
		{ "s",     "[s", { desc = "prev misspelled line" } },
		{ "n",     "]s", { desc = "next misspelled line", private = true } },
		{ "p",     "[s", { desc = "prev misspelled line", private = true } },
		{ "<ESC>", nil,  { nowait = true, exit = true } },
		{ "<BS>",  nil,  { nowait = true, exit = true } },
	},
})

Hydra({
	name = "Unimpaired Next",
	body = "]",
	mode = "n",
	heads = {
		{ "f",     "]m", { desc = "next function" } },
		{ "n",     "]m", { desc = "next function", private = true } },
		{ "p",     "[m", { desc = "prev function", private = true } },
		{ "<ESC>", nil,  { nowait = true, exit = true } },
		{ "<BS>",  nil,  { nowait = true, exit = true } },
	},
})
Hydra({
	name = "Unimpaired Prev",
	body = "[",
	mode = "n",
	heads = {
		{ "f",     "[m", { desc = "prev function" } },
		{ "n",     "]m", { desc = "next function", private = true } },
		{ "p",     "[m", { desc = "prev function", private = true } },
		{ "<ESC>", nil,  { nowait = true, exit = true } },
		{ "<BS>",  nil,  { nowait = true, exit = true } },
	},
})

Hydra({
	name = "Unimpaired Next",
	body = "]",
	mode = "n",
	heads = {
		{ "c",     [[/<<<<<CR>]], { desc = "next conflict" } },
		{ "n",     [[/<<<<<CR>]], { desc = "next conflict", private = true } },
		{ "p",     [[?<<<<<CR>]], { desc = "prev conflict", private = true } },
		{ "<ESC>", nil,           { nowait = true, exit = true } },
		{ "<BS>",  nil,           { nowait = true, exit = true } },
	},
})
Hydra({
	name = "Unimpaired Prev",
	body = "[",
	mode = "n",
	heads = {
		{ "c",     [[?<<<<<CR>]], { desc = "prev conflict" } },
		{ "n",     [[/<<<<<CR>]], { desc = "next conflict", private = true } },
		{ "p",     [[?<<<<<CR>]], { desc = "prev conflict", private = true } },
		{ "<ESC>", nil,           { nowait = true, exit = true } },
		{ "<BS>",  nil,           { nowait = true, exit = true } },
	},
})

MyMoveChar = Hydra({
	name = "Move char",
	mode = "n",
	body = "g",
	heads = {
		{ "<LEFT>",  "xhP",       { desc = "move char left" } },
		{ "<UP>",    "xkPlxjhPk", { desc = "move char up" } },
		{ "<DOWN>",  "xjPlxhkPj", { desc = "move char down" } },
		{ "<RIGHT>", "xp",        { desc = "move char right" } },
		{ "y",       "h" },
		{ "u",       "j" },
		{ "i",       "k" },
		{ "o",       "l" },
		{ "h",       "h" },
		{ "j",       "j" },
		{ "k",       "k" },
		{ "l",       "l" },
		{ "b",       "b" },
		{ "w",       "w" },
		{ "^",       "^" },
		{ "$",       "$" },
		{ "<ESC>",   nil,         { nowait = true, exit = true } },
		{ "<BS>",    nil,         { nowait = true, exit = true } },
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

require("harpoon").setup({
	menu = {
		width = math.floor(vim.api.nvim_win_get_width(0) * 0.75),
	},
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.md" },
	command = "set conceallevel=2",
})

-- local statusline = require('statusline')
-- statusline.tabline = false
require("mini.statusline").setup()

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Fold all imports in a file
vim.keymap.set("n", "zi", "<cmd>%g/^import/norm zfip<cr>")

-- Open image file in markdown
-- Example string: ![[this image.png]]
vim.keymap.set(
	"n",
	"go",
	"yi]:call system('open ' . substitute('<C-r>0', '\\v\\[?([^]]*)\\]?', '\"\\1\"', 'g'))<CR>",
	{ silent = true }
)

-- Repeatable macro that will:
-- * go to the `z` mark
-- * copy the word on the line below
-- * delete the line
-- * go back in the jumplist
-- * apply a subsititute of all instances of placeHolder in a paragraph to the copied word, matching casing
--   * case sensitive replacements:
--     * placeHolder
--     * PlaceHolder
--     * place holder
--     * Place Holder
--     * Place holder
--     * place_holder
--     * place-holder
--     * PLACE_HOLDER
vim.fn.setreg("p", "'z\r\"aYdd\15vip:S/placeHolder/\18a/g\r}jzz", "c")

if vim.loop.fs_stat(vim.fn.stdpath("config") .. "/lua/init_local.lua") then
	require("init_local")
end
