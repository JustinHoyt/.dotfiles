local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd[[
  augroup Packer
    autocmd!
    autocmd BufWritePost plugins.lua PackerCompile
  augroup end
]]

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
      theme = 'auto',
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

local telescopeConfig = function()
  require('telescope').setup {
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
  vim.api.nvim_set_keymap('n', '<leader>f', ':Telescope<CR>', {noremap = true})
  vim.api.nvim_set_keymap('n', '<leader>f/', ':Telescope live_grep<CR>', {noremap = true})
  vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', {noremap = true})
  vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', {noremap = true})
  vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope git_files<CR>', {noremap = true})
end

local oscyankConfig = function()
  vim.api.nvim_set_keymap('v', '<leader>y', ':OSCYank<CR>', {noremap = true})
  vim.api.nvim_set_keymap('n', '<leader>y', '<Plug>OSCYank', {noremap = false})
end

local alphaConfig = function ()
  require'alpha'.setup(require'alpha.themes.startify'.opts)
end

local treeSitterConfig = function()
  local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

  parser_configs.norg = {
    install_info = {
      url = "https://github.com/nvim-neorg/tree-sitter-norg",
      files = { "src/parser.c", "src/scanner.cc" },
      branch = "main"
    },
  }
  require'nvim-treesitter.configs'.setup {
    ensure_installed = { 
      'norg',
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
  require("gitlinker").setup {
    callbacks = {
      ["git.amazon.com"] = require'amazon'.get_amazon_type_url,
    },
  }
end

local neorgConfig = function()
  require('neorg').setup {
    load = {
      ["core.defaults"] = {}, -- Load all the default modules
      ["core.keybinds"] = { -- Configure core.keybinds
        config = {
          default_keybinds = true, -- Generate the default keybinds
          neorg_leader = "<Leader>o" -- This is the default if unspecified
        }
      },
      ["core.norg.concealer"] = {}, -- Allows for use of icons
      ["core.norg.dirman"] = { -- Manage your directories with Neorg
        config = { workspaces = { my_workspace = "~/Documents/neorg" } }
      }
    },
  }
end

local nvimTreeConfig = function() 
  require'nvim-tree'.setup {} 
  vim.api.nvim_set_keymap('n', '<C-t>', ':NvimTreeToggle<CR>', {noremap = true})
end

local neogitConfig = function()
  vim.api.nvim_set_keymap('n', '<C-t>', ':NvimTreeToggle<CR>', {noremap = true})
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
  use 'honza/vim-snippets'
  use 'rakr/vim-one'
  use 'tpope/vim-fugitive'
  use 'RRethy/vim-illuminate'
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
  use 'mg979/vim-visual-multi'
  use 'svermeulen/vim-yoink'
  use 'yazgoo/yank-history'
  use 'ggandor/lightspeed.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'sindrets/diffview.nvim'
  use { 'ruifm/gitlinker.nvim', config = gitlinkerConfig, }
  use { "nvim-neorg/neorg", config = neorgConfig, }
  use { "folke/which-key.nvim", config = function() require("which-key").setup {} end }
  use { 'TimUntersberger/neogit', config = neogitConfig, integrations = { diffview = true }, }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = treeSitterConfig, }
  use { 'kyazdani42/nvim-tree.lua', config = nvimTreeConfig, }
  use { 'goolord/alpha-nvim', config = alphaConfig, }
  use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }
  use { 'ojroques/vim-oscyank', config = oscyankConfig, }
  use { 'kyazdani42/nvim-web-devicons', config = webDevIconsConfig, }
  use { 'nvim-lualine/lualine.nvim', config = luaLineConfig, }
  use { 'nvim-telescope/telescope.nvim',
    requires = { {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } },
    config = telescopeConfig
  }
  if packer_bootstrap then
    require('packer').sync()
  end
end)

