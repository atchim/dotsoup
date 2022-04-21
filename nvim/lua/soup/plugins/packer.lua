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
  local use_2a = _local_2_["use"]
  local _4_
  do
    local t_3_ = require("soup.plugins.cmp")
    if (nil ~= t_3_) then
      t_3_ = (t_3_).config
    else
    end
    _4_ = t_3_
  end
  local _7_
  do
    local t_6_ = require("soup.plugins.luasnip")
    if (nil ~= t_6_) then
      t_6_ = (t_6_).config
    else
    end
    _7_ = t_6_
  end
  use_2a({config = _4_, requires = {"hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-nvim-lua", "hrsh7th/cmp-path", {config = _7_, requires = "rafamadriz/friendly-snippets", "L3MON4D3/LuaSnip"}, "saadparwaiz1/cmp_luasnip", {after = "copilot.lua", "zbirenbaum/copilot-cmp"}}, "hrsh7th/nvim-cmp"})
  local _10_
  do
    local t_9_ = require("soup.plugins.copilot")
    if (nil ~= t_9_) then
      t_9_ = (t_9_).config
    else
    end
    _10_ = t_9_
  end
  use_2a({config = _10_, event = "VimEnter", "zbirenbaum/copilot.lua"})
  local _13_
  do
    local t_12_ = require("soup.plugins.lspconfig")
    if (nil ~= t_12_) then
      t_12_ = (t_12_).config
    else
    end
    _13_ = t_12_
  end
  use_2a({config = _13_, requires = "williamboman/nvim-lsp-installer", "neovim/nvim-lspconfig"})
  local _16_
  do
    local t_15_ = require("soup.plugins.sopa")
    if (nil ~= t_15_) then
      t_15_ = (t_15_).config
    else
    end
    _16_ = t_15_
  end
  use_2a({config = _16_, "atchim/sopa.nvim"})
  use_2a({ft = "sxhkdrc", "baskerville/vim-sxhkdrc"})
  use_2a("editorconfig/editorconfig-vim")
  use_2a("elihunter173/dirbuf.nvim")
  use_2a("tpope/vim-surround")
  use_2a({opt = true, "wbthomason/packer.nvim"})
  local _19_
  do
    local t_18_ = require("soup.plugins.leap")
    if (nil ~= t_18_) then
      t_18_ = (t_18_).config
    else
    end
    _19_ = t_18_
  end
  use_2a({config = _19_, event = "VimEnter", "ggandor/leap.nvim"})
  local _22_
  do
    local t_21_ = require("soup.plugins.telescope")
    if (nil ~= t_21_) then
      t_21_ = (t_21_).config
    else
    end
    _22_ = t_21_
  end
  use_2a({config = _22_, event = "VimEnter", requires = {{run = "make", "nvim-telescope/telescope-fzf-native.nvim"}, "nvim-lua/plenary.nvim"}, "nvim-telescope/telescope.nvim"})
  local _25_
  do
    local t_24_ = require("soup.plugins.harpoon")
    if (nil ~= t_24_) then
      t_24_ = (t_24_).config
    else
    end
    _25_ = t_24_
  end
  use_2a({config = _25_, requires = "nvim-lua/plenary.nvim", "ThePrimeagen/harpoon"})
  local _28_
  do
    local t_27_ = require("soup.plugins.treesitter")
    if (nil ~= t_27_) then
      t_27_ = (t_27_).config
    else
    end
    _28_ = t_27_
  end
  use_2a({config = _28_, event = "VimEnter", "nvim-treesitter/nvim-treesitter"})
  use_2a({event = "VimEnter", "nvim-treesitter/playground"})
  use_2a({event = "VimEnter", "nvim-treesitter/nvim-treesitter-textobjects"})
  local _31_
  do
    local t_30_ = require("soup.plugins.bufferline")
    if (nil ~= t_30_) then
      t_30_ = (t_30_).config
    else
    end
    _31_ = t_30_
  end
  use_2a({config = _31_, event = "VimEnter", "akinsho/bufferline.nvim"})
  local _34_
  do
    local t_33_ = require("soup.plugins.which-key")
    if (nil ~= t_33_) then
      t_33_ = (t_33_).config
    else
    end
    _34_ = t_33_
  end
  use_2a({config = _34_, "folke/which-key.nvim"})
  local _37_
  do
    local t_36_ = require("soup.plugins.neo-tree")
    if (nil ~= t_36_) then
      t_36_ = (t_36_).config
    else
    end
    _37_ = t_36_
  end
  local _40_
  do
    local t_39_ = require("soup.plugins.neo-tree")
    if (nil ~= t_39_) then
      t_39_ = (t_39_).setup
    else
    end
    _40_ = t_39_
  end
  use_2a({branch = "v2.x", config = _37_, requires = {"MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim"}, setup = _40_, "nvim-neo-tree/neo-tree.nvim"})
  local _43_
  do
    local t_42_ = require("soup.plugins.heirline")
    if (nil ~= t_42_) then
      t_42_ = (t_42_).config
    else
    end
    _43_ = t_42_
  end
  return use_2a({config = _43_, event = "VimEnter", requires = "kyazdani42/nvim-web-devicons", "rebelot/heirline.nvim"})
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
