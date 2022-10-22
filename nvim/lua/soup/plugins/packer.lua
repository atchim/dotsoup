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
  local function _6_()
    return true
  end
  local _8_
  do
    local t_7_ = require("soup.plugins.cmp")
    if (nil ~= t_7_) then
      t_7_ = (t_7_).config
    else
    end
    _8_ = t_7_
  end
  local _11_
  do
    local t_10_ = require("soup.plugins.lspconfig")
    if (nil ~= t_10_) then
      t_10_ = (t_10_).config
    else
    end
    _11_ = t_10_
  end
  local _14_
  do
    local t_13_ = require("soup.plugins.luasnip")
    if (nil ~= t_13_) then
      t_13_ = (t_13_).config
    else
    end
    _14_ = t_13_
  end
  use({cond = _6_, config = _8_, requires = {{after = "nvim-cmp", "hrsh7th/cmp-buffer"}, {after = "nvim-cmp", requires = {{config = _11_, opt = true, requires = {{opt = true, "williamboman/nvim-lsp-installer"}}, wants = "nvim-lsp-installer", "neovim/nvim-lspconfig"}}, wants = "nvim-lspconfig", "hrsh7th/cmp-nvim-lsp"}, {after = "nvim-cmp", "hrsh7th/cmp-nvim-lua"}, {after = "nvim-cmp", "hrsh7th/cmp-path"}, {after = "nvim-cmp", requires = {{config = _14_, opt = true, requires = {{opt = true, "rafamadriz/friendly-snippets"}}, wants = "friendly-snippets", "L3MON4D3/LuaSnip"}}, "saadparwaiz1/cmp_luasnip"}}, wants = "LuaSnip", "hrsh7th/nvim-cmp"})
  use({ft = "sxhkdrc", "baskerville/vim-sxhkdrc"})
  local _17_
  do
    local t_16_ = require("soup.plugins.hydra")
    if (nil ~= t_16_) then
      t_16_ = (t_16_).config
    else
    end
    _17_ = t_16_
  end
  use({config = _17_, "anuvyklack/hydra.nvim"})
  local _20_
  do
    local t_19_ = require("soup.plugins.which-key")
    if (nil ~= t_19_) then
      t_19_ = (t_19_).config
    else
    end
    _20_ = t_19_
  end
  use({config = _20_, "folke/which-key.nvim"})
  use("elihunter173/dirbuf.nvim")
  local _23_
  do
    local t_22_ = require("soup.plugins.leap")
    if (nil ~= t_22_) then
      t_22_ = (t_22_).config
    else
    end
    _23_ = t_22_
  end
  use({config = _23_, "ggandor/leap.nvim"})
  local function _25_()
    return true
  end
  local _27_
  do
    local t_26_ = require("soup.plugins.telescope")
    if (nil ~= t_26_) then
      t_26_ = (t_26_).config
    else
    end
    _27_ = t_26_
  end
  use({cond = _25_, config = _27_, requires = {{opt = true, "nvim-lua/plenary.nvim"}, {opt = true, run = "make", "nvim-telescope/telescope-fzf-native.nvim"}}, wants = {"plenary.nvim", "telescope-fzf-native.nvim"}, "nvim-telescope/telescope.nvim"})
  local function _29_()
    return true
  end
  local _31_
  do
    local t_30_ = require("soup.plugins.harpoon")
    if (nil ~= t_30_) then
      t_30_ = (t_30_).config
    else
    end
    _31_ = t_30_
  end
  use({cond = _29_, config = _31_, requires = {{opt = true, "nvim-lua/plenary.nvim"}}, wants = "plenary.nvim", "ThePrimeagen/harpoon"})
  use("editorconfig/editorconfig-vim")
  local _34_
  do
    local t_33_ = require("soup.plugins.comment")
    if (nil ~= t_33_) then
      t_33_ = (t_33_).config
    else
    end
    _34_ = t_33_
  end
  use({config = _34_, "numToStr/Comment.nvim"})
  use("tpope/vim-surround")
  use("nvim-treesitter/nvim-treesitter-textobjects")
  local _37_
  do
    local t_36_ = require("soup.plugins.playground")
    if (nil ~= t_36_) then
      t_36_ = (t_36_).config
    else
    end
    _37_ = t_36_
  end
  use({config = _37_, "nvim-treesitter/playground"})
  local _40_
  do
    local t_39_ = require("soup.plugins.treesitter")
    if (nil ~= t_39_) then
      t_39_ = (t_39_).config
    else
    end
    _40_ = t_39_
  end
  use({config = _40_, "nvim-treesitter/nvim-treesitter"})
  local _43_
  do
    local t_42_ = require("soup.plugins.bufferline")
    if (nil ~= t_42_) then
      t_42_ = (t_42_).config
    else
    end
    _43_ = t_42_
  end
  use({config = _43_, "akinsho/bufferline.nvim"})
  local _46_
  do
    local t_45_ = require("soup.plugins.indent-blankline")
    if (nil ~= t_45_) then
      t_45_ = (t_45_).config
    else
    end
    _46_ = t_45_
  end
  use({config = _46_, "lukas-reineke/indent-blankline.nvim"})
  local _49_
  do
    local t_48_ = require("soup.plugins.neo-tree")
    if (nil ~= t_48_) then
      t_48_ = (t_48_).config
    else
    end
    _49_ = t_48_
  end
  local _52_
  do
    local t_51_ = require("soup.plugins.window-picker")
    if (nil ~= t_51_) then
      t_51_ = (t_51_).config
    else
    end
    _52_ = t_51_
  end
  use({branch = "v2.x", config = _49_, event = "VimEnter", requires = {{opt = true, "MunifTanjim/nui.nvim"}, {opt = true, "nvim-lua/plenary.nvim"}, {config = _52_, opt = true, "s1n7ax/nvim-window-picker"}}, wants = {"nui.nvim", "nvim-window-picker", "plenary.nvim"}, "nvim-neo-tree/neo-tree.nvim"})
  local _55_
  do
    local t_54_ = require("soup.plugins.heirline")
    if (nil ~= t_54_) then
      t_54_ = (t_54_).config
    else
    end
    _55_ = t_54_
  end
  return use({config = _55_, event = "VimEnter", requires = {{opt = true, "kyazdani42/nvim-web-devicons"}}, wants = "nvim-web-devicons", "rebelot/heirline.nvim"})
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
