(import-macros {: call : get : ty=} :fnl.soup.macros)

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
      :config (get :soup.plugins.cmp :config)
      :event :VimEnter
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
                  :wants :friendly-snippets}]}
          { 1 :zbirenbaum/copilot-cmp
            :after :nvim-cmp
            :requires
              [ { 1 :zbirenbaum/copilot.lua
                  :config (get :soup.plugins.copilot :config)
                  :opt true}]
            :wants :copilot.lua}]
      :wants :LuaSnip})

  ; File Type
  (use {1 :baskerville/vim-sxhkdrc :ft :sxhkdrc})

  ; Pickers / File System
  (use {1 :elihunter173/dirbuf.nvim :event :VimEnter})
  (use
    { 1 :ggandor/leap.nvim
      :config (get :soup.plugins.leap :config)
      :event :VimEnter})
  (use
    { 1 :nvim-telescope/telescope.nvim
      :config (get :soup.plugins.telescope :config)
      :event :VimEnter
      :requires
        [ {1 :nvim-lua/plenary.nvim :opt true}
          {1 :nvim-telescope/telescope-fzf-native.nvim :opt true :run :make}]
      :wants [:plenary.nvim :telescope-fzf-native.nvim]})
  (use
    { 1 :ThePrimeagen/harpoon
      :config (get :soup.plugins.harpoon :config)
      :event :VimEnter
      :requires [{1 :nvim-lua/plenary.nvim :opt true}]
      :wants :plenary.nvim})

  ; Text Manipulation
  (use {1 :editorconfig/editorconfig-vim :event :VimEnter})
  (use
    { 1 :numToStr/Comment.nvim
      :event :VimEnter
      :config (get :soup.plugins.comment :config)})
  (use {1 :tpope/vim-surround :event :VimEnter})

  ; Tree-Sitter
  (use
    { 1 :nvim-treesitter/nvim-treesitter
      :config (get :soup.plugins.treesitter :config)
      :event :VimEnter
      :requires
        [ { 1 :nvim-treesitter/playground
            :after :nvim-treesitter}
          { 1 :nvim-treesitter/nvim-treesitter-textobjects
            :after :nvim-treesitter}]})

  ; UI
  (use
    { 1 :akinsho/bufferline.nvim
      :config (get :soup.plugins.bufferline :config)
      :event :VimEnter})
  (use
    { 1 :folke/which-key.nvim
      :config (get :soup.plugins.which-key :config)})
  (use
    { 1 :lukas-reineke/indent-blankline.nvim
      :config (get :soup.plugins.indent-blankline :config)
      :event :VimEnter})
  (use
    { 1 :nvim-neo-tree/neo-tree.nvim
      ; NOTE: For now, Packer only accepts one package in `wants`, so make sure
      ; `plenary.nvim` gets loaded first.
      :after :plenary.nvim
      :branch :v2.x
      :config (get :soup.plugins.neo-tree :config)
      :requires
        [ {1 :MunifTanjim/nui.nvim :opt true}
          {1 :nvim-lua/plenary.nvim :opt true}]
      :wants :nui.nvim})
  (use
    { 1 :rebelot/heirline.nvim
      ;:commit :0b93d18 ; NOTE: Commits after this are broken.
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
