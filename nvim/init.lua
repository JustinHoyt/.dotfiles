vim.g.mapleader = ' '
--  Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.maplocalleader = ' '

vim.o.background='light'

-- Install package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim"
        },
        opts = { lsp = { auto_attach = true } }
      },
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
        path = 3,
      },
      symbols = {
        modified = '[+]',      -- Text to show when the file is modified.
        readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
        unnamed = '[No Name]', -- Text to show for unnamed buffers.
        newfile = '[New]',     -- Text to show for newly created file before first write
      }
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    },
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- Smart quote and paren pairing
  {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      opts = {} -- this is equalent to setup({}) function
  },

  -- Overwrites 's' and 'r' keys to act as jump motions
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = { modes = { char = { enabled = false } } },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- File system plugin that allows editing and manipulating files in buffers
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- underline the word your cursor is on
  { 'echasnovski/mini.cursorword', version = '*', opts = {} },

  -- Toggle terminals that run in a small bottom buffer
  {'akinsho/toggleterm.nvim', version = "*", config = true},

  {
    'echasnovski/mini.move',
    version = '*',
    config = {
      mappings = {
        -- Move current block in Visual mode
        left = '<LEFT>',
        down = '<DOWN>',
        up = '<UP>',
        right = '<RIGHT>',

        -- Move current line in Normal mode
        line_left = '<LEFT>',
        line_right = '<RIGHT>',
        line_down = '<DOWN>',
        line_up = '<UP>',
      }
    }
  },

  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {},
  },

  {
    "andrewferrier/debugprint.nvim",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    version = "*",
    config = function()
      require("debugprint").setup({})

      vim.keymap.set("v", "gd", function()
          return require('debugprint').debugprint({variable = true})
      end, { expr = true })
      vim.keymap.set("n", "yd", function()
          return require('debugprint').debugprint({ motion = true })
      end, { expr = true })
    end
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
        }
      })
    end
  },

  {
    "cseickel/diagnostic-window.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      vim.keymap.set('n', '<Space>e', ':DiagWindowShow<CR>', { silent = true })
    end,
  },

  {
    "johmsalas/text-case.nvim",
    config = function()
      require('textcase').setup {}
    end
  },

  {
    'mhinz/vim-signify',
    config = function()
      vim.keymap.set('n', '<Space>hd', ':SignifyHunkDiff<CR>', { silent = true })
      vim.keymap.set('n', '<Space>hu', ':SignifyHunkUndo<CR>', { silent = true })
      vim.keymap.set('n', '<Space>hf', ':SignifyFold<CR>', { silent = true })
      vim.keymap.set('n', '<Space>ha', ':SignifyDiff<CR>', { silent = true })
      vim.keymap.set('n', '<Space>hh', ':SignifyToggleHighLight<CR>', { silent = true })
    end,
  }, -- Git and mercurial sign column

  'ray-x/guihua.lua', -- recommended if need floating window support
  'ray-x/go.nvim',
  'nickeb96/fish.vim',
  'mg979/vim-visual-multi', -- Multicursor mode
  'tpope/vim-surround', -- Surround text-objects with pairs like () or ''
  'tpope/vim-repeat',
  'ThePrimeagen/harpoon', -- Enhance marks
  'jghauser/mkdir.nvim',
  'ojroques/nvim-osc52',
}

if vim.loop.fs_stat(vim.fn.stdpath('config') .. '/lua/google-plugins.lua') then
    table.insert(plugins, { import = "google-plugins" })
end

require('lazy').setup(plugins, {})

-- [[ Toggle background for light and dark mode ]]
function _G.toggle_background()
  if vim.o.background == 'dark' then
    vim.o.background = 'light'
  else
    vim.o.background = 'dark'
  end
end

-- [[ Setting options ]]

-- Set highlight on search
vim.o.hlsearch = false

vim.o.hidden = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Sync with system clipboard
vim.o.clipboard = 'unnamedplus'

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.relativenumber = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

local delete_swap = function()
    local filename = vim.fn.substitute(vim.fn.expand('%:p'), '/', '%', 'g')

    local swapdir = vim.o.directory
    local swapfile = vim.fn.fnamemodify(swapdir, ':p') .. filename .. '.swp'

    if vim.fn.filereadable(swapfile) == 1 then
        vim.fn.delete(swapfile)
        vim.cmd('echom "Deleted swapfile: ' .. swapfile .. '"')
    else
        vim.cmd('echom "No swapfile found for current file"')
        vim.cmd('echom "Swap file: ' .. swapfile .. '"')
    end
end

-- Format markdown lines to uppercase first character and add a period to the end.
vim.keymap.set('n', '<leader>=', [[:s/\v[a-z]/\U&/<CR>:s/\v[^\.]$/&./<CR>]], { noremap = true, silent = true })
vim.keymap.set('v', '<leader>=', [[:s/\v[a-z]/\U&/<CR>:'<,'>s/\v[^\.]$/&./<CR>]], { noremap = true, silent = true })

vim.keymap.set('n', '<leader>%', ':lua delete_swap()<CR>', { noremap = true, silent = true })

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>scs', require('telescope.builtin').commands, { desc = '[S]earch [C]ommands' })
vim.keymap.set('n', '<leader>sch', require('telescope.builtin').command_history, { desc = '[S]earch [C]ommand [H]istory' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sj', require('telescope.builtin').jumplist, { desc = '[S]earch [J]umplist' })
vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sm', require('telescope.builtin').man_pages, { desc = '[S]earch [M]an pages' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('v', '<leader>s', require('telescope.builtin').grep_string, { desc = '[S]earch' })

-- telescope LSP commands
vim.keymap.set('n', '<leader>lci', require('telescope.builtin').lsp_incoming_calls, { desc = '[L]sp [C]alls [I]ncoming' })
vim.keymap.set('n', '<leader>lco', require('telescope.builtin').lsp_outgoing_calls, { desc = '[L]sp [C]alls [O]utgoing' })
vim.keymap.set('n', '<leader>ld', require('telescope.builtin').lsp_definitions, { desc = '[L]sp [D]efinitions' })
vim.keymap.set('n', '<leader>li', require('telescope.builtin').lsp_implementations, { desc = '[L]sp [I]mplementations' })
vim.keymap.set('n', '<leader>lr', require('telescope.builtin').lsp_references, { desc = '[L]sp [R]eferences' })
vim.keymap.set('n', '<leader>lt', require('telescope.builtin').lsp_type_definitions, { desc = '[L]sp [T]ype Definitions' })
vim.keymap.set('n', '<leader>lwd', require('telescope.builtin').lsp_dynamic_workspace_symbols, { desc = '[L]sp [W]orkspace [D]ynamic Symbols' })
vim.keymap.set('n', '<leader>lws', require('telescope.builtin').lsp_workspace_symbols, { desc = '[L]sp [W]orkspace [S]ymbols' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', 'ge', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  nmap('gh', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-s>', vim.lsp.buf.signature_help, 'Signature Documentation')
  vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature Documentation' })

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
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
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- [[ vim-signify config ]]
vim.g.signify_vcs_list = { 'hg', 'git' }
vim.g.signify_sign_change = '*'
vim.g.signify_sign_delete = '-'

-- [[ Personal keymaps ]]

-- Open init.lua
vim.keymap.set('n', '<leader>v', ':e ~/.config/nvim/init.lua<CR>', {noremap = true, silent = true})

-- Reverse highlighted lines
vim.keymap.set('v', '<leader>rv', [[:g/^/m <C-r>=line('.') - 1<CR><CR>]], {noremap = true, silent = true})

-- Open a file running watcher by executing the current file as a script
vim.api.nvim_set_keymap(
  'n',
  '<leader>te',
  ':bot 15sp | terminal chmod +x ' .. vim.fn.expand('%') .. ' && echo ' .. vim.fn.expand('%') .. ' | entr -c -r ' .. vim.fn.expand('%') .. '<CR><C-w><C-k>',
  { noremap = true, silent = true, desc = '[T]erminal [E]xecute file' }
)

-- Open a file running watcher by executing the current file as a fish script
vim.api.nvim_set_keymap(
  'n',
  '<leader>tf',
  ':bot 15sp | terminal echo ' .. vim.fn.expand('%') .. ' | entr -c -r fish ' .. vim.fn.expand('%') .. '<CR><C-w><C-k>',
  { noremap = true, silent = true, desc = '[T]erminal execute [F]ish file' }
)


-- Ex command shortcuts
vim.keymap.set('n', '<leader>j', ':w<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>k', ':q<CR>', {noremap = true, silent = true})

-- Navigate between windows with Ctrl-[h|j|k|l]
vim.keymap.set('t', '<C-h>', '<C-\\><C-N><C-h>', {noremap = true})
vim.keymap.set('t', '<C-j>', '<C-\\><C-N><C-j>', {noremap = true})
vim.keymap.set('t', '<C-k>', '<C-\\><C-N><C-k>', {noremap = true})
vim.keymap.set('t', '<C-l>', '<C-\\><C-N><C-l>', {noremap = true})
vim.keymap.set('t', '<C-=>', '<C-\\><C-N><C-W><C-=>', {noremap = true})
vim.keymap.set('t', '<esc><esc>', '<C-\\><C-N>', {noremap = true})

-- Regex substitute with very magic mode shortcut
vim.keymap.set('n', 'gs', ':%s#\\v#&#g<left><left><left><left>', {noremap = true})

-- Paste all regex line matches to the current line
vim.keymap.set('n', '<leader>gp', [[:mark z | g//t 'z<left><left><left><left><left>]], {noremap = true, desc = '[G]lobal [P]ut'})

-- Rerun the last terminal command and come back to the editor
vim.keymap.set('n', '<leader>rp', '<ESC><C-w>ji<UP><CR><C-\\><C-N><C-w>k', {noremap = true, desc = '[R]e[p]eat'})

-- Search from current file's directory
vim.keymap.set('n', '<leader>f', ':e %:h/**/*', {noremap = true})

-- Map the function to a key combination
vim.keymap.set('n', '<leader>`', ':lua toggle_background()<CR>', {noremap = true})

-- angular keymaps
vim.keymap.set('n', 'gjh', ':silent! e `angular_switch % html`<CR>', {noremap = true, desc = '[G]o [J]ump to [H]tml', silent = true})
vim.keymap.set('n', 'gjc', ':silent! e `angular_switch % component`<CR>', {noremap = true, desc = '[G]o [J]ump to [C]omponent', silent = true})
vim.keymap.set('n', 'gjt', ':silent! e `angular_switch % test`<CR>', {noremap = true, desc = '[G]o [J]ump to [T]est', silent = true})
vim.keymap.set('n', 'gjs', ':silent! e `angular_switch % scss`<CR>', {noremap = true, desc = '[G]o [J]ump to [S]css', silent = true})

-- [[ nvim-osc52 ]]
local function copy(lines, _)
  require('osc52').copy(table.concat(lines, '\n'))
end

local function paste()
  return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
end

vim.g.clipboard = {
  name = 'osc52',
  copy = {['+'] = copy, ['*'] = copy},
  paste = {['+'] = paste, ['*'] = paste},
}

-- d/D delete instead of cut
vim.keymap.set({'n', 'v'}, 'd', '"_d', {noremap = true})
vim.keymap.set('n', 'dd', '"_dd', {noremap = true})
vim.keymap.set('n', 'D', '"_D', {noremap = true})

-- c/C delete instead of cut
vim.keymap.set({'n', 'v'}, 'c', '"_c', {noremap = true})
vim.keymap.set('n', 'cc', '"_cc', {noremap = true})
vim.keymap.set('n', 'C', '"_C', {noremap = true})

-- x/X as cut motion
vim.keymap.set({'n', 'v'}, 'x', 'd', {noremap = true})
vim.keymap.set('n', 'xx', 'dd', {noremap = true})
vim.keymap.set('n', 'X', 'D', {noremap = true})
vim.keymap.set('n', 'xp', '"zdl"zp', {noremap = true})

-- p deletes in visual mode
vim.keymap.set('v', 'p', '"_dP', {noremap = true})

-- [[ Macros ]]
-- Convert github URL to a string of the user/project
vim.cmd([[let @p="==yss'$a,\<Esc>F/;ldT'"]])

-- [[ oil.nvim ]]
vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })

-- [[ harpoon ]]
vim.keymap.set("n", "mc", ':lua require("harpoon.mark").add_file()<CR>', { desc = "[H]arpoon [C]reate mark", silent = true })
vim.keymap.set("n", "mm", ':lua require("harpoon.ui").toggle_quick_menu()<CR>', { desc = "[H]arpoon [M]enu", silent = true })
vim.keymap.set("n", "mn", ':lua require("harpoon.ui").nav_next()<CR>', { desc = "[H]arpoon [N]ext", silent = true })
vim.keymap.set("n", "mp", ':lua require("harpoon.ui").nav_prev()<CR>', { desc = "[H]arpoon [P]revious", silent = true })
vim.keymap.set("n", "ma", ':lua require("harpoon.ui").nav_file(1)<CR>', { desc = "[H]arpoon [1]", silent = true })
vim.keymap.set("n", "ms", ':lua require("harpoon.ui").nav_file(2)<CR>', { desc = "[H]arpoon [2]", silent = true })
vim.keymap.set("n", "md", ':lua require("harpoon.ui").nav_file(3)<CR>', { desc = "[H]arpoon [3]", silent = true })
vim.keymap.set("n", "mf", ':lua require("harpoon.ui").nav_file(4)<CR>', { desc = "[H]arpoon [4]", silent = true })
vim.keymap.set("n", "mg", ':lua require("harpoon.ui").nav_file(5)<CR>', { desc = "[H]arpoon [5]", silent = true })
vim.keymap.set("n", "mh", ':lua require("harpoon.ui").nav_file(6)<CR>', { desc = "[H]arpoon [6]", silent = true })
vim.keymap.set("n", "mj", ':lua require("harpoon.ui").nav_file(7)<CR>', { desc = "[H]arpoon [7]", silent = true })
vim.keymap.set("n", "mk", ':lua require("harpoon.ui").nav_file(8)<CR>', { desc = "[H]arpoon [8]", silent = true })
vim.keymap.set("n", "ml", ':lua require("harpoon.ui").nav_file(9)<CR>', { desc = "[H]arpoon [9]", silent = true })
vim.keymap.set("n", "m;", ':lua require("harpoon.ui").nav_file(10)<CR>', { desc = "[H]arpoon [10]", silent = true })
vim.keymap.set("n", "mt", ':lua require("harpoon.term").gotoTerminal(1)<CR>', { desc = "[H]arpoon [T]erminal 1", silent = true })
vim.keymap.set("n", "my", ':lua require("harpoon.term").gotoTerminal(2)<CR>', { desc = "[H]arpoon [T]erminal 2", silent = true })
vim.keymap.set("t", "<C-o>", '<C-\\><C-N><C-o><CR>', { desc = "Go back in jumplist", silent = true })

-- [[ onedark ]]
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

-- [[ toggleterm ]]
require("toggleterm").setup{}
vim.keymap.set({ 'i', 't', 'n' }, '<C-t><C-t>', '<C-\\><C-N>:ToggleTerm<CR>', { desc = '[T]oggleTerm [E]very' })
vim.keymap.set({ 'i', 't', 'n' }, '<C-t><C-e>', '<C-\\><C-N>:ToggleTermToggleAll<CR>', { desc = '[T]oggleTerm [E]very' })
vim.keymap.set({ 'i', 't', 'n' }, '<C-t><C-a>', '<C-\\><C-N>:ToggleTerm 1<CR>', { desc = '[T]oggleTerm [1]', silent = true })
vim.keymap.set({ 'i', 't', 'n' }, '<C-t><C-s>', '<C-\\><C-N>:ToggleTerm 2<CR>', { desc = '[T]oggleTerm [2]', silent = true })
vim.keymap.set({ 'i', 't', 'n' }, '<C-t><C-d>', '<C-\\><C-N>:ToggleTerm 3<CR>', { desc = '[T]oggleTerm [3]', silent = true })
vim.keymap.set({ 'i', 't', 'n' }, '<C-t><C-f>', '<C-\\><C-N>:ToggleTerm 4<CR>', { desc = '[T]oggleTerm [4]', silent = true })
vim.keymap.set({ 'i', 't', 'n' }, '<C-t><C-g>', '<C-\\><C-N>:ToggleTerm 5<CR>', { desc = '[T]oggleTerm [5]', silent = true })
vim.keymap.set({ 'i', 't', 'n' }, '<C-t><C-h>', '<C-\\><C-N>:ToggleTerm 6<CR>', { desc = '[T]oggleTerm [6]', silent = true })
vim.keymap.set({ 'i', 't', 'n' }, '<C-t><C-j>', '<C-\\><C-N>:ToggleTerm 7<CR>', { desc = '[T]oggleTerm [7]', silent = true })
vim.keymap.set({ 'i', 't', 'n' }, '<C-t><C-k>', '<C-\\><C-N>:ToggleTerm 8<CR>', { desc = '[T]oggleTerm [8]', silent = true })
vim.keymap.set({ 'i', 't', 'n' }, '<C-t><C-l>', '<C-\\><C-N>:ToggleTerm 9<CR>', { desc = '[T]oggleTerm [9]', silent = true })
vim.keymap.set({ 'i', 't', 'n' }, '<C-t><C-;>', '<C-\\><C-N>:ToggleTerm 10<CR>', { desc = '[T]oggleTerm [10]', silent = true })

if vim.loop.fs_stat(vim.fn.stdpath('config') .. '/lua/init_local.lua') then
  require('init_local')
end
