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
      theme = 'onedark',
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
  vim.cmd[[nnoremap <silent><M-h> :BufferLineCyclePrev<CR>]]
  vim.cmd[[nnoremap <silent><M-l> :BufferLineCycleNext<CR>]]
  require'bufferline'.setup{
    options = {
      indicator_icon = '  ',
      buffer_close_icon = '',
      modified_icon = '●',
      close_icon = '',
      close_command = "bdelete %d",
      right_mouse_command = "bdelete! %d",
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
  update_focused_file = {
    enable = true,
    update_cwd = true
  },
})
  vim.api.nvim_set_keymap('n', '<C-t>', ':NvimTreeFindFileToggle<CR>', {noremap = true})
end

local vimVisualMultiConfig = function()
  vim.api.nvim_set_keymap('n', '<M-d>', '<Plug>(VM-Find-Under)', {noremap = false})
  vim.api.nvim_set_keymap('n', '<M-j>', '<Plug>(VM-Add-Cursor-Down)', {noremap = false})
  vim.api.nvim_set_keymap('n', '<M-k>', '<Plug>(VM-Add-Cursor-Up)', {noremap = false})
  vim.api.nvim_set_keymap('n', '<C-n>', '<Plug>(VM-Find-Under)', {noremap = false})
  vim.api.nvim_set_keymap('n', '<C-Down>', '<Plug>(VM-Add-Cursor-Down)', {noremap = false})
  vim.api.nvim_set_keymap('n', '<C-Up>', '<Plug>(VM-Add-Cursor-Up)', {noremap = false})
end

local oneDarkConfig = function()
  require('onedark').setup({
    functionStyle = "italic",
    sidebars = {"qf", "vista_kind", "terminal", "packer"},

    -- Change the "hint" color to the "orange" color, and make the "error" color bright red
    colors = {hint = "orange", error = "#ff0000"}
  })

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
        peek_definition_code = {
          ["<leader>gf"] = "@function.outer",
          ["<leader>gc"] = "@class.outer",
        },
      },
    },
  }
end

local nvimNotifyConfig = function()
  vim.notify = require("notify")
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
  use 'ggandor/lightspeed.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'sindrets/diffview.nvim'
  use 'nvim-telescope/telescope-project.nvim'
  use 'williamboman/nvim-lsp-installer'
  use { 'RRethy/vim-illuminate', config = vimIlluminateConfig }
  use { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup{} end }
  use { 'rcarriga/nvim-notify', config = nvimNotifyConfig }
  use { 'nvim-treesitter/nvim-treesitter-textobjects', config = treeSitterTextObjectsConfig }
  use { 'monsonjeremy/onedark.nvim', config = oneDarkConfig }
  use { 'akinsho/bufferline.nvim', config = bufferlineConfig } 
  use { 'mg979/vim-visual-multi', config = vimVisualMultiConfig }
  use { 'ruifm/gitlinker.nvim', config = gitlinkerConfig, }
  use { "folke/which-key.nvim", config = function() require("which-key").setup {} end }
  use { 'TimUntersberger/neogit', config = neogitConfig, integrations = { diffview = true } }
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
  if packer_bootstrap then
    require('packer').sync()
  end
end)

