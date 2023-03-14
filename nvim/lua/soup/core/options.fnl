(fn setup []
  "Sets up core options."

  (let [o vim.opt]
    ; Case
    (set o.ignorecase true)
    (set o.smartcase true)
    (set o.tagcase :followscs)

    ; Chars
    (set o.fillchars
      { :fold " "
        :horiz " "
        :horizdown " "
        :horizup " "
        :vert " "
        :verthoriz " "
        :vertleft " "
        :vertright " "})
    (set o.listchars
      { :eol :$
        :conceal :%
        :extends :>
        :nbsp :+
        :precedes :<
        :space :.
        :tab "> "
        :trail "~"})

    ; Indentation
    (set o.breakindent true)
    (set o.copyindent true)
    (set o.expandtab true)
    (set o.preserveindent true)
    (set o.shiftround true)
    (set o.shiftwidth 0)
    (set o.smartindent true)
    (set o.tabstop 2)

    ; Performance
    (set o.lazyredraw true)
    (set o.ttimeoutlen 0)
    (set o.updatetime 250)

    ; UI
    (set o.cmdheight 0)
    (set o.colorcolumn :+1)
    (set o.conceallevel 2)
    (set o.cursorline true)
    (set o.cursorlineopt [:number])
    (set o.laststatus 3)
    (set o.number true)
    (set o.relativenumber true)
    (set o.showmatch true)
    (set o.termguicolors true)
    (set o.title true)
    (set o.visualbell true)

    ; Misc
    (set o.clipboard :unnamed)
    (set o.foldlevelstart 99)
    (set o.mouse :ar)
    (set o.spelllang :en_us)
    (set o.textwidth 79)
    (set o.undofile true)))

{: setup}
