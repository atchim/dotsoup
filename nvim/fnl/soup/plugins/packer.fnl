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

  (local {:use use*} (require :packer))

  (macro use [plugin ...]
    "Expand dynamically generated `use*` statements.

    `plugin` must be a string which stands for the name of the plugin.

    `[...]` must always have an even length and its items must alternate
    between odd-indexed strings and even-indexed arbitrary values. The
    odd-indexed strings will be evaluated as indexes for their consecutive
    even-indexed values.

    If the length of `[...]` is zero, this macro returns a call to the `use`
    function passing the string `plugin` as its only argument. Otherwise, this
    macro returns a call to the `use` function, this time passing a table to
    the function. The table contains the package name as its only
    number-indexed value. The table also contains keys and values according
    with items of `[...]`.

      (use :foo) ; Evaluates to `(use* :foo)`.
      (use :foo :bar) ; Invalid! Length of `[...]` is odd.
      (use :foo :bar baz) ; Evaluates to `(use* {1 :foo :bar baz})`."

    (local {: ty=} (require :fnl.soup.macros))
    (ty= plugin :string)
    (local args [...])
    (local len (length args))
    (assert (= 0 (% len 2)) "`[...]` doesn't have an even length")

    (if (= 0 len)
      `(use* ,plugin)
      (let [t {1 plugin}]
        (for [i 1 len 2]
          (local key (. args i))
          (ty= key :string)
          (tset t key (. args (+ 1 i))))
        `(use* ,t))))

  ; Completion
  (use :hrsh7th/nvim-cmp
    :config (get :soup.plugins.cmp :config)
    :requires
      [ :hrsh7th/cmp-buffer
        :hrsh7th/cmp-nvim-lsp
        :hrsh7th/cmp-nvim-lua
        :hrsh7th/cmp-path
        { 1 :L3MON4D3/LuaSnip
          :config (get :soup.plugins.luasnip :config)
          :requires :rafamadriz/friendly-snippets}
        :saadparwaiz1/cmp_luasnip
        { 1 :zbirenbaum/copilot-cmp :after :copilot.lua}])
  (use :zbirenbaum/copilot.lua
    :config (get :soup.plugins.copilot :config)
    :event :VimEnter)


  ; LSP
  (use :neovim/nvim-lspconfig
    :config (get :soup.plugins.lspconfig :config)
    :requires :williamboman/nvim-lsp-installer)

  ; Misc
  (use :atchim/sopa.nvim
    :config (get :soup.plugins.sopa :config))
  (use :baskerville/vim-sxhkdrc :ft :sxhkdrc)
  (use :editorconfig/editorconfig-vim)
  (use :elihunter173/dirbuf.nvim)
  (use :tpope/vim-surround)
  (use :wbthomason/packer.nvim :opt true)

  ; Pickers
  (use :ggandor/leap.nvim
    :config (get :soup.plugins.leap :config)
    :event :VimEnter)
  (use :nvim-telescope/telescope.nvim
    :config (get :soup.plugins.telescope :config)
    :event :VimEnter
    :requires
      [ {1 :nvim-telescope/telescope-fzf-native.nvim :run :make}
        :nvim-lua/plenary.nvim])
  (use :ThePrimeagen/harpoon
    :config (get :soup.plugins.harpoon :config)
    :requires :nvim-lua/plenary.nvim)

  ; Tree Sitter
  (use :nvim-treesitter/nvim-treesitter
    :config (get :soup.plugins.treesitter :config)
    :event :VimEnter)
  (use :nvim-treesitter/playground
    :event :VimEnter)
  (use :nvim-treesitter/nvim-treesitter-textobjects
    :event :VimEnter)

  ; UI
  (use :akinsho/bufferline.nvim
    :config (get :soup.plugins.bufferline :config)
    :event :VimEnter)
  (use :folke/which-key.nvim
    :config (get :soup.plugins.which-key :config))
  (use :nvim-neo-tree/neo-tree.nvim
    :branch :v2.x
    :config (get :soup.plugins.neo-tree :config)
    :requires
      [ :MunifTanjim/nui.nvim
        :nvim-lua/plenary.nvim]
    :setup (get :soup.plugins.neo-tree :setup))
  (use :rebelot/heirline.nvim
    :config (get :soup.plugins.heirline :config)
    :event :VimEnter
    :requires :kyazdani42/nvim-web-devicons))

(fn init []
  "Initiate Packer."
  (local err vim.api.nvim_err_writeln)
  (if (= (bootstrap) 0)
    (do
      (vim.cmd "packadd packer.nvim")
      (call :packer :startup user))
    (err "unable to install `packer.nvim`")))

{: init}
