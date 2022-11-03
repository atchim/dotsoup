(import-macros {: modcall : modget?} :soupmacs.soupmacs)

(fn bootstrap []
  "Attempts to install Packer and return the process exit code."
  (let
    [path (.. (vim.fn.stdpath :data) :/site/pack/packer/opt/packer.nvim)]
    (if (> (vim.fn.empty (vim.fn.glob path)) 0)
      (let [url :https://github.com/wbthomason/packer.nvim]
        (vim.fn.system [:git :clone :--depth :1 url path])
        vim.v.shell_error)
      0)))

(fn user []
  "Sets plugin specifications via `use` function from Packer."

  (local {: use} (require :packer))
  (use {1 :wbthomason/packer.nvim :opt true})
  (use {1 :editorconfig/editorconfig-vim :event :UIEnter})
  (use {1 :atchim/sopa.nvim :config (modget? :soup.plugins.sopa :config)})

  (use
    { 1 :folke/which-key.nvim
      :event :UIEnter
      :config
        #(do
          (set vim.opt.timeoutlen 500)
          (modcall :which-key :setup ()))})

  (use
    { 1 :nvim-treesitter/nvim-treesitter
      :event :UIEnter
      :config (modget? :soup.plugins.treesitter :config)})
  (use
    { 1 :nvim-treesitter/nvim-treesitter-textobjects
      :after :nvim-treesitter})
  (use
    { 1 :nvim-treesitter/playground
      :after :nvim-treesitter
      :config
        #(modcall
          :soup.core.maps
          :map
          ( {:p [:<Cmd>TSPlaygroundToggle<CR> "Tree-Sitter Playground"]}
            {:prefix :<Leader>t}))})

  (use
    { 1 :hrsh7th/nvim-cmp
      :event :UIEnter
      :config (modget? :soup.plugins.cmp :config)
      :requires
        [ {1 :hrsh7th/cmp-buffer :after :nvim-cmp}
          { 1 :hrsh7th/cmp-nvim-lsp
            :after :nvim-cmp
            :requires
              [ { 1 :neovim/nvim-lspconfig
                  :config (modget? :soup.plugins.lspconfig :config)
                  :opt true
                  :requires [{1 :williamboman/nvim-lsp-installer :opt true}]
                  :wants :nvim-lsp-installer}]
            :wants :nvim-lspconfig}
          {1 :hrsh7th/cmp-nvim-lua :after :nvim-cmp}
          {1 :hrsh7th/cmp-path :after :nvim-cmp}
          { 1 :saadparwaiz1/cmp_luasnip
            :after :nvim-cmp
            :requires
              [ { 1 :L3MON4D3/LuaSnip
                  :config #(modcall :luasnip.loaders.from_vscode :lazy_load ())
                  :opt true
                  :requires [{1 :rafamadriz/friendly-snippets :opt true}]
                  :wants :friendly-snippets}]}]
      :wants :LuaSnip})

  (use
    { 1 :nvim-telescope/telescope.nvim
      :event :UIEnter
      :config (modget? :soup.plugins.telescope :config)
      :requires
        [ {1 :nvim-lua/plenary.nvim :opt true}
          {1 :nvim-telescope/telescope-fzf-native.nvim :opt true :run :make}]
      :wants [:plenary.nvim :telescope-fzf-native.nvim]})

  (use
    { 1 :nvim-neo-tree/neo-tree.nvim
      :branch :v2.x
      :config (modget? :soup.plugins.neo-tree :config)
      :event :UIEnter
      :requires
        [ {1 :kyazdani42/nvim-web-devicons :opt true}
          {1 :MunifTanjim/nui.nvim :opt true}
          {1 :nvim-lua/plenary.nvim :opt true}
          { 1 :s1n7ax/nvim-window-picker
            :config (modget? :soup.plugins.window-picker :config)
            :opt true}]
      :wants [:nui.nvim :nvim-web-devicons :nvim-window-picker :plenary.nvim]})

  (use
    { 1 :rebelot/heirline.nvim
      :event :UIEnter
      :config (modget? :soup.plugins.heirline :config)
      :requires [{1 :kyazdani42/nvim-web-devicons :opt true}]
      :wants :nvim-web-devicons})

  (use
    { 1 :ggandor/leap.nvim
      :event :InsertCharPre
      :config #(modcall :leap :set_default_keymaps ())})

  (use
    { 1 :numToStr/Comment.nvim
      :config
        #(modcall
          :Comment
          :setup
          { :opleader {:block :gC}
            :padding false
            :toggler {:block :gcC}})})

  (use
    { 1 :kylechui/nvim-surround
      :event :InsertCharPre
      :config #(modcall :nvim-surround :setup {})})

  (use
    { 1 :lewis6991/gitsigns.nvim
      :event :UIEnter
      :config #(modcall :gitsigns :setup {})})

  (use
    { 1 :ThePrimeagen/harpoon
      :event :UIEnter
      :config (modget? :soup.plugins.harpoon :config)
      :requires [{1 :nvim-lua/plenary.nvim :opt true}]
      :wants :plenary.nvim})

  (use
    { 1 :lukas-reineke/indent-blankline.nvim
      :config
        #(do
          (modcall
            :indent_blankline
            :setup
            { :enabled false
              :show_current_context true
              :show_current_context_start true})
          (modcall
            :soup.core.maps
            :map
            ( {:i [:<Cmd>IndentBlanklineToggle<CR> "Indent Blankline"]}
              {:prefix :<Leader>t})))})

  (use
    { 1 :uga-rosa/ccc.nvim
      :event :UIEnter
      :config (modget? :soup.plugins.ccc :config)})

  (use
    { 1 :folke/noice.nvim
      :event :UIEnter
      :config (modget? :soup.plugins.noice :config)})

  (use
    { 1 :j-hui/fidget.nvim
      :config #(modcall :fidget :setup {:text {:spinner :dots}})}))

(local M {})

(fn M.init []
  "Initializes Packer."
  (local err vim.api.nvim_err_writeln)
  (if (= (bootstrap) 0)
    (do
      (vim.cmd "packadd packer.nvim")
      (modcall :packer :startup user))
    (err "unable to install `packer.nvim`")))

M
