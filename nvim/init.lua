-- Install packer
vim.o.background='dark'
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', { command = 'source <afile> | PackerCompile', group = packer_group, pattern = 'init.lua' })


require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-surround' -- Surround text-objects with pairs like () or ''
  use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  use 'tpope/vim-repeat' -- Fugitive-companion to interact with github
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'navarasu/onedark.nvim'
  use 'ojroques/vim-oscyank' -- Yank to clipboard
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'williamboman/nvim-lsp-installer'
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'windwp/nvim-autopairs' -- Autopairs
  use 'kyazdani42/nvim-web-devicons' -- Pretty icons
  use 'mg979/vim-visual-multi' -- Multicursor mode
  use 'RRethy/vim-illuminate' -- Highlight other words that match the word under the cursor
  use { "folke/which-key.nvim", config = function() require("which-key").setup {} end }
  use 'Olical/conjure' -- Interactive Lisp evaluator
  use 'nickeb96/fish.vim'
  use 'ray-x/go.nvim'
  use 'ray-x/guihua.lua' -- recommended if need floating window support
  use 'nvim-treesitter/nvim-treesitter'
end)

require('go').setup()

--Set highlight on search
vim.o.hlsearch = false

--Make relative line numbers default
vim.wo.number = true
vim.opt.relativenumber = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Set tab to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

--Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme onedark]]

--Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.o.splitbelow = true

--Remove empty spaces on save
vim.cmd [[autocmd BufWritePre * :%s/\s\+$//e]]

--Set statusbar
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'onedark',
    component_separators = '|',
    section_separators = '',
  },
}

--Enable Comment.nvim
require('Comment').setup({})

--Remap space as leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.api.nvim_set_keymap('n', '<leader>v', ':silent e ~/.config/nvim/init.lua<CR>', {noremap = true})

vim.api.nvim_set_keymap('n', '<leader>t', ':bot 15sp term://fish<CR>i', {noremap = true})

vim.api.nvim_set_keymap('n', '<leader>ps', ':PackerSync<CR>', {noremap = true})

vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true})
vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true})

vim.api.nvim_set_keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', {noremap = true})
vim.api.nvim_set_keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', {noremap = true})
vim.api.nvim_set_keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', {noremap = true})
vim.api.nvim_set_keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', {noremap = true})
vim.api.nvim_set_keymap('t', '<esc><esc>', '<C-\\><C-N>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-h>', '<C-\\><C-N><C-w>h', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-j>', '<C-\\><C-N><C-w>j', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-k>', '<C-\\><C-N><C-w>k', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-l>', '<C-\\><C-N><C-w>l', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-=>', '<C-W><C-=>', {noremap = true})

vim.api.nvim_set_keymap('n', '<leader>l', '<ESC><C-w>ji<UP><CR><C-\\><C-N><C-w>k', {noremap = true})

--Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Indent blankline
require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
}

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

--Add leader shortcuts
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers)
vim.keymap.set('n', '<leader>sf', function()
  require('telescope.builtin').find_files { previewer = false }
end)
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').current_buffer_fuzzy_find)
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags)
vim.keymap.set('n', '<leader>st', require('telescope.builtin').tags)
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').grep_string)
vim.keymap.set('n', '<leader>sp', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>so', function()
  require('telescope.builtin').tags { only_current_buffer = true }
end)
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles)

require('onedark').setup  {
  -- Main options --
  style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
  transparent = true,  -- Show/hide background
  term_colors = true, -- Change terminal color as per the selected theme style
  ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
  -- toggle theme style ---
  toggle_style_key = '<leader>o', -- Default keybinding to toggle
  toggle_style_list = {'light', 'dark'}, -- List of styles to toggle between

  -- Change code style ---
  -- Options are italic, bold, underline, none
  -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
  code_style = {
      comments = 'italic',
      keywords = 'none',
      functions = 'none',
      strings = 'none',
      variables = 'none'
  },

  -- Custom Highlights --
  colors = {}, -- Override default colors
  highlights = {}, -- Override highlight groups

  -- Plugins Config --
  diagnostics = {
      darker = true, -- darker colors for diagnostic
      undercurl = true,   -- use undercurl instead of underline for diagnostics
      background = true,    -- use background color for virtual text
  },
}
require('onedark').load()

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- LSP settings
require("nvim-lsp-installer").setup {}

local lspconfig = require 'lspconfig'
local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wl', function()
    vim.inspect(vim.lsp.buf.list_workspace_folders())
  end, opts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>so', require('telescope.builtin').lsp_document_symbols, opts)
  vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
end

-- -- nvim-cmp supports additional completion capabilities
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

require'cmp'.setup {
  sources = {
    { name = 'nvim_lsp' }
  }
}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()


-- Enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'rnix', 'jdtls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
-- vim: ts=2 sts=2 sw=2 et


-- OSC Yank config
vim.cmd([[
	augroup TextYank
	autocmd!
		autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankRegister "' | endif
	augroup END
]])

require('nvim-autopairs').setup{
  check_ts = true,
  enable_check_bracket_line = false
}

require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

-- vim-visual-multi
vim.api.nvim_set_keymap('n', '<M-d>', '<Plug>(VM-Find-Under)', {noremap = false})
vim.api.nvim_set_keymap('n', '<C-n>', '<Plug>(VM-Find-Under)', {noremap = false})
vim.api.nvim_set_keymap('n', '<C-Down>', '<Plug>(VM-Add-Cursor-Down)', {noremap = false})
vim.api.nvim_set_keymap('n', '<C-Up>', '<Plug>(VM-Add-Cursor-Up)', {noremap = false})

-- vim-illuminate
vim.cmd([[
  augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedWord guibg=#3A3F49
    autocmd VimEnter * hi illuminatedCurWord guibg=#3A3F49 cterm=underline gui=underline
  augroup END
]])
