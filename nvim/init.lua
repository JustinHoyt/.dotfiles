require('plugins')

-------------
-- Options --
-------------

vim.opt.scrolloff = 1
vim.opt.number = true
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.inccommand = 'nosplit'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.updatetime = 100
vim.opt.cmdheight = 2
vim.opt.smartcase = true
vim.opt.background = 'light'
vim.opt.encoding = 'utf8'
vim.opt.cursorline = true
vim.opt.mouse = 'a'
vim.api.nvim_command([[
  colorscheme one
  let g:startify_change_to_vcs_root=1
  let g:dispatch_no_tmux_make = 1
]])


--------------
-- Mappings --
--------------

-- Leader

vim.g.mapleader = ' '

vim.api.nvim_set_keymap('n', '<leader>+', ':exe "resize " . (winheight(0) * 3/2)<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>-', ':exe "resize " . (winheight(0) * 2/3)<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ev', ':silent e ~/.config/nvim/init.lua<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ep', ':silent e ~/.config/nvim/lua/plugins.lua<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>pi', ':PackerInstall<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ps', ':PackerSync<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>pc', ':PackerClean<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>rp', ':w<CR>:!python3 %<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>rj', ':w<CR>:!node %<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>bn', ':bn<CR>     " Move to the next buffer', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>bp', ':bp<CR>     " Move to the previous buffer', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>n', ':noh<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'gt', ':!ctags -R --exclude=.git --exclude=node_modules --exclude=out --exclude=build .<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'gb', ':ls<CR>:b<Space>', {noremap = true})
vim.api.nvim_set_keymap('n', 'Y', 'y$', {noremap = true})
vim.api.nvim_set_keymap('n', 'gs', ':mksession! ./.session.vim<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'gl', ':source ./.session.vim<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '[l', ':set norelativenumber nonumber<CR>:GitGutterDisable<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', ']l', ':set relativenumber number<CR>:GitGutterEnable<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', 'yob', ':call ToggleBackground()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>d', ':Gdiff<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>t', ':15sp term://zsh<CR>i', {noremap = true})

-- more natural windows mappings
vim.api.nvim_set_keymap('t', '<A-h>', '<C-\\><C-N><C-w>h', {noremap = true})
vim.api.nvim_set_keymap('t', '<A-j>', '<C-\\><C-N><C-w>j', {noremap = true})
vim.api.nvim_set_keymap('t', '<A-k>', '<C-\\><C-N><C-w>k', {noremap = true})
vim.api.nvim_set_keymap('t', '<A-l>', '<C-\\><C-N><C-w>l', {noremap = true})
vim.api.nvim_set_keymap('t', '<esc><esc>', '<C-\\><C-N>', {noremap = true})
vim.api.nvim_set_keymap('i', '<A-h>', '<C-\\><C-N><C-w>h', {noremap = true})
vim.api.nvim_set_keymap('i', '<A-j>', '<C-\\><C-N><C-w>j', {noremap = true})
vim.api.nvim_set_keymap('i', '<A-k>', '<C-\\><C-N><C-w>k', {noremap = true})
vim.api.nvim_set_keymap('i', '<A-l>', '<C-\\><C-N><C-w>l', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-h>', '<C-w>h', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-j>', '<C-w>j', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-k>', '<C-w>k', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-l>', '<C-w>l', {noremap = true})
vim.api.nvim_set_keymap('n', '<A-=>', '<C-W><C-=>', {noremap = true})


vim.api.nvim_command([[
function UpdateBackground()
    if system("defaults read -g AppleInterfaceStyle") == "Dark\n"
        if &bg == "light" | set bg=dark | endif
    else
        if &bg == "dark" | set bg=light | endif
    endif
    runtime autoload/lightline/colorscheme/one.vim
endfunction

function ToggleBackground()
    if &bg == "light"
        set bg=dark
    else
        set bg=light
    endif
    runtime autoload/lightline/colorscheme/one.vim
endfunction

"-----auto-commands-----"
if has('nvim') && has('mac')
    augroup nightfall
      autocmd!
      autocmd FocusGained,BufEnter * call UpdateBackground()
    augroup END
endif
]])

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

-- Setup nvim-cmp.
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})
-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})
-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})


require('lsp_config')

-- Setup lspconfig.
local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local servers = { 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

run_checkstyle = function()
     vim.api.nvim_command('set makeprg=brazil-build')
     vim.api.nvim_command('set errorformat=[checkstyle]\\ [%.%#]\\ %f:%l:%c:\\ %m,[checkstyle]\\ [%.%#]\\ %f:%l:\\ %m')
     vim.api.nvim_command('let &shellpipe="2>&1 | tee /tmp/checkstyle-errors.txt | grep checkstyle | grep ERROR &> %s"')
     vim.api.nvim_command('Make')
end  

vim.api.nvim_set_keymap('n', '<leader>c', ':lua run_checkstyle()<CR>', {noremap = true})