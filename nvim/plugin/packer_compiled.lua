-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/local/home/hoyjusti/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/local/home/hoyjusti/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/local/home/hoyjusti/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/local/home/hoyjusti/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/local/home/hoyjusti/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["cmp-buffer"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-vsnip"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/cmp-vsnip",
    url = "https://github.com/hrsh7th/cmp-vsnip"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n¢\5\0\0\a\0\"\00036\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\t\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0034\4\0\0=\4\b\3=\3\n\0025\3\f\0005\4\v\0=\4\r\0035\4\14\0005\5\15\0005\6\16\0=\6\17\5>\5\3\4=\4\18\0035\4\19\0=\4\20\0035\4\21\0=\4\22\0035\4\23\0=\4\24\0035\4\25\0=\4\26\3=\3\27\0025\3\28\0004\4\0\0=\4\r\0034\4\0\0=\4\18\0035\4\29\0=\4\20\0035\4\30\0=\4\22\0034\4\0\0=\4\24\0034\4\0\0=\4\26\3=\3\31\0024\3\0\0=\3 \0024\3\0\0=\3!\2B\0\2\1K\0\1\0\15extensions\ftabline\22inactive_sections\1\2\0\0\rlocation\1\2\0\0\rfilename\1\0\0\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\4\0\0\rencoding\15fileformat\rfiletype\14lualine_c\1\2\0\0\rfilename\14lualine_b\fsources\1\3\0\0\rnvim_lsp\bcoc\1\2\0\0\16diagnostics\1\3\0\0\vbranch\tdiff\14lualine_a\1\0\0\1\2\0\0\tmode\foptions\1\0\0\23disabled_filetypes\23section_separators\1\0\2\tleft\bî‚°\nright\bî‚²\25component_separators\1\0\2\tleft\bî‚±\nright\bî‚³\1\0\3\25always_divide_middle\2\ntheme\tauto\18icons_enabled\2\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\n;\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\20vsnip#anonymous\afn\bvim§\5\1\0\n\0*\0\\6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\6\0005\4\4\0003\5\3\0=\5\5\4=\4\a\0035\4\v\0009\5\b\0009\a\b\0009\a\t\a)\tüÿB\a\2\0025\b\n\0B\5\3\2=\5\f\0049\5\b\0009\a\b\0009\a\t\a)\t\4\0B\a\2\0025\b\r\0B\5\3\2=\5\14\0049\5\b\0009\a\b\0009\a\15\aB\a\1\0025\b\16\0B\5\3\2=\5\17\0049\5\18\0009\5\19\5=\5\20\0049\5\b\0005\a\22\0009\b\b\0009\b\21\bB\b\1\2=\b\23\a9\b\b\0009\b\24\bB\b\1\2=\b\25\aB\5\2\2=\5\26\0049\5\b\0009\5\27\0055\a\28\0B\5\2\2=\5\29\4=\4\b\0039\4\18\0009\4\30\0044\6\3\0005\a\31\0>\a\1\0065\a \0>\a\2\0064\a\3\0005\b!\0>\b\1\aB\4\3\2=\4\30\3B\1\2\0019\1\2\0009\1\"\1'\3#\0005\4%\0004\5\3\0005\6$\0>\6\1\5=\5\30\4B\1\3\0019\1\2\0009\1\"\1'\3&\0005\4)\0009\5\18\0009\5\30\0054\a\3\0005\b'\0>\b\1\a4\b\3\0005\t(\0>\t\1\bB\5\3\2=\5\30\4B\1\3\1K\0\1\0\1\0\0\1\0\1\tname\fcmdline\1\0\1\tname\tpath\6:\1\0\0\1\0\1\tname\vbuffer\6/\fcmdline\1\0\1\tname\vbuffer\1\0\1\tname\nvsnip\1\0\1\tname\rnvim_lsp\fsources\t<CR>\1\0\1\vselect\2\fconfirm\n<C-e>\6c\nclose\6i\1\0\0\nabort\n<C-y>\fdisable\vconfig\14<C-Space>\1\3\0\0\6i\6c\rcomplete\n<C-f>\1\3\0\0\6i\6c\n<C-b>\1\0\0\1\3\0\0\6i\6c\16scroll_docs\fmapping\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\bcmp\frequire\0" },
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-jdtls"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/nvim-jdtls",
    url = "https://github.com/mfussenegger/nvim-jdtls"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\n’\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\roverride\1\0\1\fdefault\2\bzsh\1\0\0\1\0\3\tname\bZsh\ticon\bîž•\ncolor\f#428850\nsetup\22nvim-web-devicons\frequire\0" },
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n§\5\0\0\6\0 \0=6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\0025\3\t\0005\4\b\0=\4\n\3=\3\v\2B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\f\0'\2\n\0B\0\2\0016\0\r\0009\0\14\0009\0\15\0'\2\16\0'\3\17\0'\4\18\0005\5\19\0B\0\5\0016\0\r\0009\0\14\0009\0\15\0'\2\16\0'\3\20\0'\4\21\0005\5\22\0B\0\5\0016\0\r\0009\0\14\0009\0\15\0'\2\16\0'\3\23\0'\4\24\0005\5\25\0B\0\5\0016\0\r\0009\0\14\0009\0\15\0'\2\16\0'\3\26\0'\4\27\0005\5\28\0B\0\5\0016\0\r\0009\0\14\0009\0\15\0'\2\16\0'\3\29\0'\4\30\0005\5\31\0B\0\5\1K\0\1\0\1\0\1\fnoremap\2\29:Telescope git_files<CR>\15<LEADER>fg\1\0\1\fnoremap\2\30:Telescope find_files<CR>\15<LEADER>ff\1\0\1\fnoremap\2\27:Telescope buffers<CR>\15<LEADER>fb\1\0\1\fnoremap\2\29:Telescope live_grep<CR>\15<LEADER>f/\1\0\1\fnoremap\2\19:Telescope<CR>\14<LEADER>f\6n\20nvim_set_keymap\bapi\bvim\19load_extension\15extensions\bfzf\1\0\0\1\0\4\14case_mode\15smart_case\25override_file_sorter\2\28override_generic_sorter\2\nfuzzy\2\fpickers\1\0\0\15find_files\1\0\0\1\0\1\14no_ignore\2\nsetup\14telescope\frequire\0" },
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["vim-colors-github"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/vim-colors-github",
    url = "https://github.com/cormacrelf/vim-colors-github"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-gitgutter"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/vim-gitgutter",
    url = "https://github.com/airblade/vim-gitgutter"
  },
  ["vim-illuminate"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/vim-illuminate",
    url = "https://github.com/RRethy/vim-illuminate"
  },
  ["vim-one"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/vim-one",
    url = "https://github.com/rakr/vim-one"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/vim-polyglot",
    url = "https://github.com/sheerun/vim-polyglot"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/vim-snippets",
    url = "https://github.com/honza/vim-snippets"
  },
  ["vim-startify"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/vim-startify",
    url = "https://github.com/mhinz/vim-startify"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-tbone"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/vim-tbone",
    url = "https://github.com/tpope/vim-tbone"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/vim-unimpaired",
    url = "https://github.com/tpope/vim-unimpaired"
  },
  ["vim-vinegar"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/vim-vinegar",
    url = "https://github.com/tpope/vim-vinegar"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/vim-vsnip",
    url = "https://github.com/hrsh7th/vim-vsnip"
  },
  ["vim-yoink"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/vim-yoink",
    url = "https://github.com/svermeulen/vim-yoink"
  },
  ["yank-history"] = {
    loaded = true,
    path = "/local/home/hoyjusti/.local/share/nvim/site/pack/packer/start/yank-history",
    url = "https://github.com/yazgoo/yank-history"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\n;\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\20vsnip#anonymous\afn\bvim§\5\1\0\n\0*\0\\6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\6\0005\4\4\0003\5\3\0=\5\5\4=\4\a\0035\4\v\0009\5\b\0009\a\b\0009\a\t\a)\tüÿB\a\2\0025\b\n\0B\5\3\2=\5\f\0049\5\b\0009\a\b\0009\a\t\a)\t\4\0B\a\2\0025\b\r\0B\5\3\2=\5\14\0049\5\b\0009\a\b\0009\a\15\aB\a\1\0025\b\16\0B\5\3\2=\5\17\0049\5\18\0009\5\19\5=\5\20\0049\5\b\0005\a\22\0009\b\b\0009\b\21\bB\b\1\2=\b\23\a9\b\b\0009\b\24\bB\b\1\2=\b\25\aB\5\2\2=\5\26\0049\5\b\0009\5\27\0055\a\28\0B\5\2\2=\5\29\4=\4\b\0039\4\18\0009\4\30\0044\6\3\0005\a\31\0>\a\1\0065\a \0>\a\2\0064\a\3\0005\b!\0>\b\1\aB\4\3\2=\4\30\3B\1\2\0019\1\2\0009\1\"\1'\3#\0005\4%\0004\5\3\0005\6$\0>\6\1\5=\5\30\4B\1\3\0019\1\2\0009\1\"\1'\3&\0005\4)\0009\5\18\0009\5\30\0054\a\3\0005\b'\0>\b\1\a4\b\3\0005\t(\0>\t\1\bB\5\3\2=\5\30\4B\1\3\1K\0\1\0\1\0\0\1\0\1\tname\fcmdline\1\0\1\tname\tpath\6:\1\0\0\1\0\1\tname\vbuffer\6/\fcmdline\1\0\1\tname\vbuffer\1\0\1\tname\nvsnip\1\0\1\tname\rnvim_lsp\fsources\t<CR>\1\0\1\vselect\2\fconfirm\n<C-e>\6c\nclose\6i\1\0\0\nabort\n<C-y>\fdisable\vconfig\14<C-Space>\1\3\0\0\6i\6c\rcomplete\n<C-f>\1\3\0\0\6i\6c\n<C-b>\1\0\0\1\3\0\0\6i\6c\16scroll_docs\fmapping\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n§\5\0\0\6\0 \0=6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\0025\3\t\0005\4\b\0=\4\n\3=\3\v\2B\0\2\0016\0\0\0'\2\1\0B\0\2\0029\0\f\0'\2\n\0B\0\2\0016\0\r\0009\0\14\0009\0\15\0'\2\16\0'\3\17\0'\4\18\0005\5\19\0B\0\5\0016\0\r\0009\0\14\0009\0\15\0'\2\16\0'\3\20\0'\4\21\0005\5\22\0B\0\5\0016\0\r\0009\0\14\0009\0\15\0'\2\16\0'\3\23\0'\4\24\0005\5\25\0B\0\5\0016\0\r\0009\0\14\0009\0\15\0'\2\16\0'\3\26\0'\4\27\0005\5\28\0B\0\5\0016\0\r\0009\0\14\0009\0\15\0'\2\16\0'\3\29\0'\4\30\0005\5\31\0B\0\5\1K\0\1\0\1\0\1\fnoremap\2\29:Telescope git_files<CR>\15<LEADER>fg\1\0\1\fnoremap\2\30:Telescope find_files<CR>\15<LEADER>ff\1\0\1\fnoremap\2\27:Telescope buffers<CR>\15<LEADER>fb\1\0\1\fnoremap\2\29:Telescope live_grep<CR>\15<LEADER>f/\1\0\1\fnoremap\2\19:Telescope<CR>\14<LEADER>f\6n\20nvim_set_keymap\bapi\bvim\19load_extension\15extensions\bfzf\1\0\0\1\0\4\14case_mode\15smart_case\25override_file_sorter\2\28override_generic_sorter\2\nfuzzy\2\fpickers\1\0\0\15find_files\1\0\0\1\0\1\14no_ignore\2\nsetup\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\n’\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\roverride\1\0\1\fdefault\2\bzsh\1\0\0\1\0\3\tname\bZsh\ticon\bîž•\ncolor\f#428850\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n¢\5\0\0\a\0\"\00036\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\t\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0034\4\0\0=\4\b\3=\3\n\0025\3\f\0005\4\v\0=\4\r\0035\4\14\0005\5\15\0005\6\16\0=\6\17\5>\5\3\4=\4\18\0035\4\19\0=\4\20\0035\4\21\0=\4\22\0035\4\23\0=\4\24\0035\4\25\0=\4\26\3=\3\27\0025\3\28\0004\4\0\0=\4\r\0034\4\0\0=\4\18\0035\4\29\0=\4\20\0035\4\30\0=\4\22\0034\4\0\0=\4\24\0034\4\0\0=\4\26\3=\3\31\0024\3\0\0=\3 \0024\3\0\0=\3!\2B\0\2\1K\0\1\0\15extensions\ftabline\22inactive_sections\1\2\0\0\rlocation\1\2\0\0\rfilename\1\0\0\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\4\0\0\rencoding\15fileformat\rfiletype\14lualine_c\1\2\0\0\rfilename\14lualine_b\fsources\1\3\0\0\rnvim_lsp\bcoc\1\2\0\0\16diagnostics\1\3\0\0\vbranch\tdiff\14lualine_a\1\0\0\1\2\0\0\tmode\foptions\1\0\0\23disabled_filetypes\23section_separators\1\0\2\tleft\bî‚°\nright\bî‚²\25component_separators\1\0\2\tleft\bî‚±\nright\bî‚³\1\0\3\25always_divide_middle\2\ntheme\tauto\18icons_enabled\2\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
