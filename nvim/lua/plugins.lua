local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd([[
  augroup Packer
    autocmd!
    autocmd BufWritePost plugins.lua execute "source ~/.config/nvim/lua/plugins.lua"
    autocmd BufWritePost plugins.lua PackerSync
  augroup end
]])

local webDevIconsConfig = function()
  require'nvim-web-devicons'.setup {
    -- your personnal icons can go here (to override)
    -- DevIcon will be appended to `name`
    override = {
      zsh = {
        icon = "",
        color = "#428850",
        name = "Zsh"
      }
    };
    -- globally enable default icons (default to false)
    -- will get overriden by `get_icons` option
    default = true;
  }
end

local luaLineConfig = function()
  require'lualine'.setup {
    options = {
      icons_enabled = true,
      theme = 'onedark-nvim',
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {},
      always_divide_middle = true,
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', {'diagnostics', sources={'nvim_diagnostic'}}},
      lualine_c = {'filename'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    extensions = {}
  }
end

local bufferlineConfig = function()
  vim.cmd[[nnoremap <silent> gb :BufferLinePick<CR>]]
  vim.cmd[[nnoremap <silent><M-j> :BufferLineCyclePrev<CR>]]
  vim.cmd[[nnoremap <silent><M-k> :BufferLineCycleNext<CR>]]
  vim.cmd[[nnoremap <silent><M-w> :Bdelete<CR>]]
  require'bufferline'.setup{
    options = {
      indicator_icon = '  ',
      buffer_close_icon = '',
      modified_icon = '●',
      close_icon = '',
      close_command = "Bdelete %d",
      right_mouse_command = "Bdelete! %d",
      left_trunc_marker = '',
      right_trunc_marker = '',
      offsets = {{filetype = "NvimTree", text = "EXPLORER", text_align = "center"}},
      show_tab_indicators = true,
      show_close_icon = false
    },
    highlights = {
      fill = {
        guifg = {attribute = "fg", highlight = "Normal"},
        guibg = {attribute = "bg", highlight = "StatusLineNC"},
      },
      background = {
        guifg = {attribute = "fg", highlight = "Normal"},
        guibg = {attribute = "bg", highlight = "StatusLine"}
      },
      buffer_visible = {
        gui = "",
        guifg = {attribute = "fg", highlight="Normal"},
        guibg = {attribute = "bg", highlight = "Normal"}
      },
      buffer_selected = {
        gui = "",
        guifg = {attribute = "fg", highlight="Normal"},
        guibg = {attribute = "bg", highlight = "Normal"}
      },
      separator = {
        guifg = {attribute = "bg", highlight = "Normal"},
        guibg = {attribute = "bg", highlight = "StatusLine"},
      },
      separator_selected = {
        guifg = {attribute = "fg", highlight="Special"},
        guibg = {attribute = "bg", highlight = "Normal"}
      },
      separator_visible = {
        guifg = {attribute = "fg", highlight = "Normal"},
        guibg = {attribute = "bg", highlight = "StatusLineNC"},
      },
      close_button = {
        guifg = {attribute = "fg", highlight = "Normal"},
        guibg = {attribute = "bg", highlight = "StatusLine"}
      },
      close_button_selected = {
        guifg = {attribute = "fg", highlight="normal"},
        guibg = {attribute = "bg", highlight = "normal"}
      },
      close_button_visible = {
        guifg = {attribute = "fg", highlight="normal"},
        guibg = {attribute = "bg", highlight = "normal"}
      },

    }
  }
end

local telescopeConfig = function()
  require('telescope').setup {
    defaults = {
      file_ignore_patterns = {
        "node_modules",
        "build",
        "coverage",
      }
    },
    pickers = {
      find_files = {
        no_ignore = true
      }
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case"
      }
    }
  }
  require('telescope').load_extension('fzf')
  require('telescope').load_extension('project')
  vim.api.nvim_set_keymap('n', '<leader>f', ':Telescope<CR>', {noremap = true})
  vim.api.nvim_set_keymap('n', '<leader>f/', ':Telescope live_grep<CR>', {noremap = true})
  vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', {noremap = true})
  vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', {noremap = true})
  vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope git_files<CR>', {noremap = true})
  vim.api.nvim_set_keymap('n', '<leader>fh', ':Telescope help_tags<CR>', {noremap = true})
  vim.api.nvim_set_keymap('n', '<leader>fp', ":lua require'telescope'.extensions.project.project{}<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "<leader><leader>", "<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>", {noremap = true, silent = true})
end

local oscyankConfig = function()
  vim.cmd([[
    augroup TextYank
      autocmd!
      autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif
    augroup END
  ]])
end

local alphaConfig = function ()
  require'alpha'.setup(require'alpha.themes.startify'.opts)
end

local treeSitterConfig = function()
  require'nvim-treesitter.configs'.setup {
    ensure_installed = {
      'c',
      'javascript',
      'typescript',
      'java',
      'lua',
      'bash',
      'ruby',
      'vim',
      'tsx',
      'regex',
      'php',
      'python',
      'json',
      'json5',
      'html',
    },
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    highlight = {
      enable = true,              -- false will disable the whole extension
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
  }
end

local gitlinkerConfig = function()
  local hasAmazon,amazon = pcall(require,"amazon")

  if hasAmazon then
    require("gitlinker").setup {
      callbacks = {
        ["git.amazon.com"] = amazon.get_amazon_type_url,
      },
    }
  else
    require("gitlinker").setup {}
  end
end

local nvimTreeConfig = function()
  require("nvim-tree").setup({
    update_cwd = true,
    view = {
      preserve_window_proportions = true,
      number = true,
      relativenumber = true,
    },
  })
  vim.api.nvim_set_keymap('n', '<C-t>', ':NvimTreeFindFileToggle<CR>', {noremap = true})
end

local vimVisualMultiConfig = function()
  vim.api.nvim_set_keymap('n', '<M-d>', '<Plug>(VM-Find-Under)', {noremap = false})
  vim.api.nvim_set_keymap('n', '<C-n>', '<Plug>(VM-Find-Under)', {noremap = false})
  vim.api.nvim_set_keymap('n', '<C-Down>', '<Plug>(VM-Add-Cursor-Down)', {noremap = false})
  vim.api.nvim_set_keymap('n', '<C-Up>', '<Plug>(VM-Add-Cursor-Up)', {noremap = false})
end

local oneDarkConfig = function()
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
end

local treeSitterTextObjectsConfig = function()
  require'nvim-treesitter.configs'.setup {
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
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
      lsp_interop = {
        enable = true,
        border = 'none',
      },
    },
  }
end

local vimIlluminateConfig = function()
  vim.cmd([[
    augroup illuminate_augroup
      autocmd!
      autocmd VimEnter * hi illuminatedWord guibg=#3A3F49
      autocmd VimEnter * hi illuminatedCurWord guibg=#3A3F49 cterm=underline gui=underline
    augroup END
  ]])
end

local sadConfig = function()
  require'sad'.setup({
    diff = 'diff-so-fancy', -- you can use `diff`, `diff-so-fancy`
    ls_file = 'fd', -- also git ls_file
    exact = false, -- exact match
  })
end

local openBrowserConfig = function()
  vim.cmd[[let g:netrw_nogx = 1]]
	vim.cmd[[nmap gx <Plug>(openbrowser-smart-search)]]
	vim.cmd[[vmap gx <Plug>(openbrowser-smart-search)]]
end

local nvimDapUi = function()
  require("dapui").setup({
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
      -- Use a table to apply multiple mappings
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
    },
    sidebar = {
      -- You can change the order of elements in the sidebar
      elements = {
        -- Provide as ID strings or tables with "id" and "size" keys
        {
          id = "scopes",
          size = 0.25, -- Can be float or integer > 1
        },
        { id = "breakpoints", size = 0.25 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 00.25 },
      },
      size = 40,
      position = "left", -- Can be "left", "right", "top", "bottom"
    },
    tray = {
      elements = { "repl" },
      size = 10,
      position = "bottom", -- Can be "left", "right", "top", "bottom"
    },
    floating = {
      max_height = nil, -- These can be integers or a float between 0 and 1.
      max_width = nil, -- Floats will be treated as percentage of your screen.
      border = "single", -- Border style. Can be "single", "double" or "rounded"
      mappings = {
        close = { "q", "<Esc>" },
      },
    },
    windows = { indent = 1 },
  })
end

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'tpope/vim-vinegar'
  use 'tpope/vim-repeat'
  use 'tpope/vim-dispatch'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-abolish'
  use 'tpope/vim-rhubarb'
  use 'honza/vim-snippets'
  use 'rakr/vim-one'
  use 'tpope/vim-fugitive'
  use 'mfussenegger/nvim-jdtls'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'cormacrelf/vim-colors-github'
  use 'airblade/vim-gitgutter'
  use 'tpope/vim-tbone'
  use 'svermeulen/vim-yoink'
  use 'yazgoo/yank-history'
  use {
    'phaazon/hop.nvim',
    branch = 'v1', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
      -- place this in one of your configuration file(s)
      vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
      vim.api.nvim_set_keymap('n', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
      vim.api.nvim_set_keymap('o', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
      vim.api.nvim_set_keymap('o', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
      vim.api.nvim_set_keymap('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
      vim.api.nvim_set_keymap('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
      vim.api.nvim_set_keymap('n', 's', "<cmd>lua require'hop'.hint_char2()<cr>", {noremap = true})
    end
  }
  use 'nvim-lua/plenary.nvim'
  use 'sindrets/diffview.nvim'
  use 'nvim-telescope/telescope-project.nvim'
  use 'williamboman/nvim-lsp-installer'
  use 'EdenEast/nightfox.nvim'
  use 'marko-cerovac/material.nvim'
  use 'ray-x/guihua.lua'
  use 'moll/vim-bbye'
  use 'mfussenegger/nvim-dap'
  use { "rcarriga/nvim-dap-ui", config = nvimDapUi, requires = {"mfussenegger/nvim-dap"} }
  use { 'navarasu/onedark.nvim', config = oneDarkConfig }
  use { 'tyru/open-browser.vim', config = openBrowserConfig }
  use { 'ray-x/sad.nvim', config = sadConfig }
  use { 'RRethy/vim-illuminate', config = vimIlluminateConfig }
  use { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup{} end }
  use { 'nvim-treesitter/nvim-treesitter-textobjects', config = treeSitterTextObjectsConfig }
  use { 'akinsho/bufferline.nvim', config = bufferlineConfig }
  use { 'mg979/vim-visual-multi', config = vimVisualMultiConfig }
  use { 'ruifm/gitlinker.nvim', config = gitlinkerConfig, }
  use { "folke/which-key.nvim", config = function() require("which-key").setup {} end }
  use { 'TimUntersberger/neogit', integrations = { diffview = true } }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = treeSitterConfig }
  use { 'kyazdani42/nvim-tree.lua', config = nvimTreeConfig }
  use { 'goolord/alpha-nvim', config = alphaConfig }
  use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }
  use { 'ojroques/vim-oscyank', config = oscyankConfig }
  use { 'kyazdani42/nvim-web-devicons', config = webDevIconsConfig }
  use { 'nvim-lualine/lualine.nvim', config = luaLineConfig }
  use { 'nvim-telescope/telescope.nvim',
    requires = { {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } },
    config = telescopeConfig
  }
  use {
    "nvim-telescope/telescope-frecency.nvim",
    config = function() require"telescope".load_extension("frecency") end,
    requires = {"tami5/sqlite.lua"}
  }
  if packer_bootstrap then
    require('packer').sync()
  end
end)

