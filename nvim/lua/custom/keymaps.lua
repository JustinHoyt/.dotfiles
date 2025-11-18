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
