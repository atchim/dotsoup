(fn init []
  "Set options for raw editor."

  (local o vim.opt)

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

  ; FX
  (set o.conceallevel 2)
  (set o.showmatch true)
  (set o.visualbell true)

  ; Indentation
  (set o.breakindent true)
  (set o.copyindent true)
  (set o.expandtab true)
  (set o.preserveindent true)
  (set o.shiftround true)
  (set o.shiftwidth 0)
  (set o.smartindent true)
  (set o.tabstop 2)

  ; Misc
  (set o.clipboard :unnamed)
  (set o.foldlevelstart 99)
  (set o.mouse :a)
  (set o.spelllang :en_us)
  (set o.undofile true)

  ; Performance
  (set o.lazyredraw true)
  (set o.ttimeoutlen 0)
  (set o.updatetime 250)

  ; UI
  (set o.cursorline true)
  (set o.cursorlineopt [:number])
  (set o.laststatus 3)
  (set o.number true)
  (set o.pumblend 15)
  (set o.relativenumber true)
  (set o.title true)

  ; Wrap
  (set o.colorcolumn :+1)
  (set o.textwidth 79))

{: init}
