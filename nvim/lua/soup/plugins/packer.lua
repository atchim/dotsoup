local function bootstrap()
  local path = (vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim")
  if (vim.fn.empty(vim.fn.glob(path)) > 0) then
    local url = "https://github.com/wbthomason/packer.nvim"
    vim.fn.system({"git", "clone", "--depth", "1", url, path})
    return vim.v.shell_error
  else
    return 0
  end
end
local function user()
  local _local_2_ = require("packer")
  local use = _local_2_["use"]
  use({opt = true, "wbthomason/packer.nvim"})
  local _4_
  do
    local t_3_ = require("soup.plugins.sopa")
    if (nil ~= t_3_) then
      t_3_ = (t_3_).config
    else
    end
    _4_ = t_3_
  end
  use({config = _4_, "atchim/sopa.nvim"})
  local _7_
  do
    local t_6_ = require("soup.plugins.cmp")
    if (nil ~= t_6_) then
      t_6_ = (t_6_).config
    else
    end
    _7_ = t_6_
  end
  local _10_
  do
    local t_9_ = require("soup.plugins.lspconfig")
    if (nil ~= t_9_) then
      t_9_ = (t_9_).config
    else
    end
    _10_ = t_9_
  end
  local _13_
  do
    local t_12_ = require("soup.plugins.luasnip")
    if (nil ~= t_12_) then
      t_12_ = (t_12_).config
    else
    end
    _13_ = t_12_
  end
  local _16_
  do
    local t_15_ = require("soup.plugins.copilot")
    if (nil ~= t_15_) then
      t_15_ = (t_15_).config
    else
    end
    _16_ = t_15_
  end
  use({config = _7_, event = "VimEnter", requires = {{after = "nvim-cmp", "hrsh7th/cmp-buffer"}, {after = "nvim-cmp", requires = {{config = _10_, opt = true, requires = {{opt = true, "williamboman/nvim-lsp-installer"}}, wants = "nvim-lsp-installer", "neovim/nvim-lspconfig"}}, wants = "nvim-lspconfig", "hrsh7th/cmp-nvim-lsp"}, {after = "nvim-cmp", "hrsh7th/cmp-nvim-lua"}, {after = "nvim-cmp", "hrsh7th/cmp-path"}, {after = "nvim-cmp", requires = {{config = _13_, opt = true, requires = {{opt = true, "rafamadriz/friendly-snippets"}}, wants = "friendly-snippets", "L3MON4D3/LuaSnip"}}, "saadparwaiz1/cmp_luasnip"}, {after = "nvim-cmp", requires = {{config = _16_, opt = true, "zbirenbaum/copilot.lua"}}, wants = "copilot.lua", "zbirenbaum/copilot-cmp"}}, wants = "LuaSnip", "hrsh7th/nvim-cmp"})
  use({ft = "sxhkdrc", "baskerville/vim-sxhkdrc"})
  use({event = "VimEnter", "elihunter173/dirbuf.nvim"})
  local _19_
  do
    local t_18_ = require("soup.plugins.leap")
    if (nil ~= t_18_) then
      t_18_ = (t_18_).config
    else
    end
    _19_ = t_18_
  end
  use({config = _19_, event = "VimEnter", "ggandor/leap.nvim"})
  local _22_
  do
    local t_21_ = require("soup.plugins.telescope")
    if (nil ~= t_21_) then
      t_21_ = (t_21_).config
    else
    end
    _22_ = t_21_
  end
  use({config = _22_, event = "VimEnter", requires = {{opt = true, "nvim-lua/plenary.nvim"}, {opt = true, run = "make", "nvim-telescope/telescope-fzf-native.nvim"}}, wants = {"plenary.nvim", "telescope-fzf-native.nvim"}, "nvim-telescope/telescope.nvim"})
  local _25_
  do
    local t_24_ = require("soup.plugins.harpoon")
    if (nil ~= t_24_) then
      t_24_ = (t_24_).config
    else
    end
    _25_ = t_24_
  end
  use({config = _25_, event = "VimEnter", requires = {{opt = true, "nvim-lua/plenary.nvim"}}, wants = "plenary.nvim", "ThePrimeagen/harpoon"})
  use({event = "VimEnter", "editorconfig/editorconfig-vim"})
  local _28_
  do
    local t_27_ = require("soup.plugins.comment")
    if (nil ~= t_27_) then
      t_27_ = (t_27_).config
    else
    end
    _28_ = t_27_
  end
  use({event = "VimEnter", config = _28_, "numToStr/Comment.nvim"})
  use({event = "VimEnter", "tpope/vim-surround"})
  local _31_
  do
    local t_30_ = require("soup.plugins.treesitter")
    if (nil ~= t_30_) then
      t_30_ = (t_30_).config
    else
    end
    _31_ = t_30_
  end
  use({config = _31_, event = "VimEnter", requires = {{after = "nvim-treesitter", "nvim-treesitter/playground"}, {after = "nvim-treesitter", "nvim-treesitter/nvim-treesitter-textobjects"}}, "nvim-treesitter/nvim-treesitter"})
  local _34_
  do
    local t_33_ = require("soup.plugins.bufferline")
    if (nil ~= t_33_) then
      t_33_ = (t_33_).config
    else
    end
    _34_ = t_33_
  end
  use({config = _34_, event = "VimEnter", "akinsho/bufferline.nvim"})
  local _37_
  do
    local t_36_ = require("soup.plugins.which-key")
    if (nil ~= t_36_) then
      t_36_ = (t_36_).config
    else
    end
    _37_ = t_36_
  end
  use({config = _37_, "folke/which-key.nvim"})
  local _40_
  do
    local t_39_ = require("soup.plugins.indent-blankline")
    if (nil ~= t_39_) then
      t_39_ = (t_39_).config
    else
    end
    _40_ = t_39_
  end
  use({config = _40_, event = "VimEnter", "lukas-reineke/indent-blankline.nvim"})
  local _43_
  do
    local t_42_ = require("soup.plugins.neo-tree")
    if (nil ~= t_42_) then
      t_42_ = (t_42_).config
    else
    end
    _43_ = t_42_
  end
  use({after = "plenary.nvim", branch = "v2.x", config = _43_, requires = {{opt = true, "MunifTanjim/nui.nvim"}, {opt = true, "nvim-lua/plenary.nvim"}}, wants = "nui.nvim", "nvim-neo-tree/neo-tree.nvim"})
  local _46_
  do
    local t_45_ = require("soup.plugins.heirline")
    if (nil ~= t_45_) then
      t_45_ = (t_45_).config
    else
    end
    _46_ = t_45_
  end
  return use({config = _46_, event = "VimEnter", requires = {{opt = true, "kyazdani42/nvim-web-devicons"}}, wants = "nvim-web-devicons", "rebelot/heirline.nvim"})
end
local function init()
  local err = vim.api.nvim_err_writeln
  if (bootstrap() == 0) then
    vim.cmd("packadd packer.nvim")
    return (require("packer")).startup(user)
  else
    return err("unable to install `packer.nvim`")
  end
end
return {init = init}
