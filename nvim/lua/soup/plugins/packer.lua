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
  use("baskerville/bubblegum")
  local function _3_()
    local config = require("sopa.config")
    local api = vim.api
    local group = api.nvim_create_augroup("soup_core_colors", {})
    config.enabled_integrations = {"cmp", "indent-blankline", "leap", "neo-tree", "treesitter"}
    vim.opt.termguicolors = true
    return (require("sopa")).init()
  end
  use({event = "UIEnter", config = _3_, "/home/atchim/repo/sopa.nvim"})
  local function _4_()
    vim.opt.timeoutlen = 500
    do end (require("which-key")).setup()
    local labels = (require("soup.core.maps")).labels
    local _let_5_ = require("which-key")
    local register = _let_5_["register"]
    for _, _6_ in ipairs(labels) do
      local _each_7_ = _6_
      local maps = _each_7_[1]
      local _3fopts = _each_7_[2]
      register(maps, _3fopts)
    end
    return nil
  end
  use({event = "UIEnter", config = _4_, "folke/which-key.nvim"})
  use({event = "UIEnter", "editorconfig/editorconfig-vim"})
  use({event = "BufRead", config = (require("soup.plugins.treesitter")).config, "nvim-treesitter/nvim-treesitter"})
  use({after = "nvim-treesitter", requires = "nvim-treesitter", "nvim-treesitter/nvim-treesitter-textobjects"})
  local function _8_()
    return (require("soup.core.maps")).map({p = {"<Cmd>TSPlaygroundToggle<CR>", "Tree-Sitter Playground"}}, {prefix = "<Leader>t"})
  end
  use({after = "nvim-treesitter", config = _8_, requires = "nvim-treesitter", "nvim-treesitter/playground"})
  use({opt = true, "kyazdani42/nvim-web-devicons"})
  use({event = "UIEnter", config = (require("soup.plugins.ccc")).config, "uga-rosa/ccc.nvim"})
  use({event = "BufRead", config = (require("soup.plugins.heirline")).config, requires = {"ccc.nvim", "nvim-web-devicons"}, wants = {"ccc.nvim", "nvim-web-devicons", "sopa.nvim"}, "rebelot/heirline.nvim"})
  local function _9_()
    return (require("luasnip.loaders.from_vscode")).lazy_load()
  end
  use({event = "BufRead", config = (require("soup.plugins.cmp")).config, requires = {{after = "nvim-cmp", "hrsh7th/cmp-buffer"}, {after = "nvim-cmp", requires = {{config = (require("soup.plugins.lspconfig")).config, opt = true, requires = {{opt = true, "williamboman/nvim-lsp-installer"}}, wants = "nvim-lsp-installer", "neovim/nvim-lspconfig"}}, wants = "nvim-lspconfig", "hrsh7th/cmp-nvim-lsp"}, {after = "nvim-cmp", "hrsh7th/cmp-nvim-lua"}, {after = "nvim-cmp", "hrsh7th/cmp-path"}, {after = "nvim-cmp", requires = {{config = _9_, opt = true, requires = {{opt = true, "rafamadriz/friendly-snippets"}}, wants = "friendly-snippets", "L3MON4D3/LuaSnip"}}, "saadparwaiz1/cmp_luasnip"}}, wants = "LuaSnip", "hrsh7th/nvim-cmp"})
  use({opt = true, "nvim-lua/plenary.nvim"})
  use({event = "UIEnter", config = (require("soup.plugins.telescope")).config, requires = {{opt = true, run = "make", "nvim-telescope/telescope-fzf-native.nvim"}, "plenary.nvim"}, wants = {"plenary.nvim", "telescope-fzf-native.nvim"}, "nvim-telescope/telescope.nvim"})
  use({branch = "v2.x", config = (require("soup.plugins.neo-tree")).config, event = "UIEnter", requires = {{opt = true, "MunifTanjim/nui.nvim"}, "nvim-web-devicons", "plenary.nvim", {config = (require("soup.plugins.window-picker")).config, opt = true, requires = "sopa.nvim", wants = "sopa.nvim", "s1n7ax/nvim-window-picker"}}, wants = {"nui.nvim", "nvim-web-devicons", "nvim-window-picker", "plenary.nvim"}, "nvim-neo-tree/neo-tree.nvim"})
  local function _10_()
    return (require("leap")).set_default_keymaps()
  end
  use({event = "UIEnter", config = _10_, "ggandor/leap.nvim"})
  local function _11_()
    return (require("Comment")).setup({opleader = {block = "gC"}, toggler = {block = "gcC"}, padding = false})
  end
  use({event = "UIEnter", config = _11_, "numToStr/Comment.nvim"})
  local function _12_()
    return (require("nvim-surround")).setup({})
  end
  use({event = "UIEnter", config = _12_, "kylechui/nvim-surround"})
  local function _13_()
    return (require("gitsigns")).setup({})
  end
  use({event = "UIEnter", config = _13_, wants = "sopa.nvim", "lewis6991/gitsigns.nvim"})
  use({event = "UIEnter", config = (require("soup.plugins.harpoon")).config, requires = "plenary.nvim", wants = "plenary.nvim", "ThePrimeagen/harpoon"})
  local function _14_()
    do end (require("indent_blankline")).setup({show_current_context = true, show_current_context_start = true, enabled = false})
    return (require("soup.core.maps")).map({i = {"<Cmd>IndentBlanklineToggle<CR>", "Indent Blankline"}}, {prefix = "<Leader>t"})
  end
  use({event = "UIEnter", config = _14_, "lukas-reineke/indent-blankline.nvim"})
  use({disable = true, event = "UIEnter", config = (require("soup.plugins.noice")).config, "folke/noice.nvim"})
  local function _15_()
    return (require("fidget")).setup({text = {spinner = "dots"}})
  end
  return use({event = "UIEnter", config = _15_, "j-hui/fidget.nvim"})
end
local M = {}
M.init = function()
  local err = vim.api.nvim_err_writeln
  if (bootstrap() == 0) then
    vim.cmd("packadd packer.nvim")
    return (require("packer")).startup(user)
  else
    return err("unable to install `packer.nvim`")
  end
end
return M
