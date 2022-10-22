(import-macros {: call : get} :fnl.soup.macros)

(fn bootstrap []
  "Attempt to install Packer and return the process exit code."
  (local path (.. (vim.fn.stdpath :data) :/site/pack/packer/opt/packer.nvim))
  (if (> (vim.fn.empty (vim.fn.glob path)) 0)
    (let [url :https://github.com/wbthomason/packer.nvim]
      (vim.fn.system [:git :clone :--depth :1 url path])
      vim.v.shell_error)
    0))

(fn user []
  "Set plugin specifications via `use` function from Packer."

  (local {: use} (require :packer))
  (use {1 :wbthomason/packer.nvim :opt true})

  ; Color Scheme
  (use {1 :atchim/sopa.nvim :config (get :soup.plugins.sopa :config)})

  ; Completion
  (use
    { 1 :hrsh7th/nvim-cmp
      :cond (fn [] true)
      :config (get :soup.plugins.cmp :config)
      :requires
        [ {1 :hrsh7th/cmp-buffer :after :nvim-cmp}
          { 1 :hrsh7th/cmp-nvim-lsp
            :after :nvim-cmp
            :requires
              [ { 1 :neovim/nvim-lspconfig
                  :config (get :soup.plugins.lspconfig :config)
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
                  :config (get :soup.plugins.luasnip :config)
                  :opt true
                  :requires [{1 :rafamadriz/friendly-snippets :opt true}]
                  :wants :friendly-snippets}]}]
      :wants :LuaSnip})

  ; File Type
  (use {1 :baskerville/vim-sxhkdrc :ft :sxhkdrc})

  ; Key Mapping
  (use
    { 1 :anuvyklack/hydra.nvim
      :config (get :soup.plugins.hydra :config)})
  (use
    { 1 :folke/which-key.nvim
      :config (get :soup.plugins.which-key :config)})

  ; Pickers / File System
  (use :elihunter173/dirbuf.nvim)
  (use
    { 1 :ggandor/leap.nvim
      :config (get :soup.plugins.leap :config)})
  (use
    { 1 :nvim-telescope/telescope.nvim
      :cond (fn [] true)
      :config (get :soup.plugins.telescope :config)
      :requires
        [ {1 :nvim-lua/plenary.nvim :opt true}
          {1 :nvim-telescope/telescope-fzf-native.nvim :opt true :run :make}]
      :wants [:plenary.nvim :telescope-fzf-native.nvim]})
  (use
    { 1 :ThePrimeagen/harpoon
      :cond (fn [] true)
      :config (get :soup.plugins.harpoon :config)
      :requires [{1 :nvim-lua/plenary.nvim :opt true}]
      :wants :plenary.nvim})

  ; Text Manipulation
  (use :editorconfig/editorconfig-vim)
  (use
    { 1 :numToStr/Comment.nvim
      :config (get :soup.plugins.comment :config)})
  (use :tpope/vim-surround)

  ; Tree-Sitter
  (use :nvim-treesitter/nvim-treesitter-textobjects)
  (use
    { 1 :nvim-treesitter/playground
      :config (get :soup.plugins.playground :config)})
  (use
    { 1 :nvim-treesitter/nvim-treesitter
      :config (get :soup.plugins.treesitter :config)})

  ; UI
  (use
    { 1 :akinsho/bufferline.nvim
      :config (get :soup.plugins.bufferline :config)})
  (use
    { 1 :lukas-reineke/indent-blankline.nvim
      :config (get :soup.plugins.indent-blankline :config)})
  (use
    { 1 :nvim-neo-tree/neo-tree.nvim
      :branch :v2.x
      :config (get :soup.plugins.neo-tree :config)
      :event :VimEnter
      :requires
        [ {1 :MunifTanjim/nui.nvim :opt true}
          {1 :nvim-lua/plenary.nvim :opt true}
          { 1 :s1n7ax/nvim-window-picker
            :config (get :soup.plugins.window-picker :config)
            :opt true}]
      :wants [:nui.nvim :nvim-window-picker :plenary.nvim]})
  (use
    { 1 :rebelot/heirline.nvim
      :config (get :soup.plugins.heirline :config)
      :event :VimEnter
      :requires [{1 :kyazdani42/nvim-web-devicons :opt true}]
      :wants :nvim-web-devicons}))

(fn init []
  "Initiate Packer."
  (local err vim.api.nvim_err_writeln)
  (if (= (bootstrap) 0)
    (do
      (vim.cmd "packadd packer.nvim")
      (call :packer :startup user))
    (err "unable to install `packer.nvim`")))

{: init}
