; TODO: Enhance buffer line.
; TODO: Make use of the `update` field for on-demand event-based updates.
; TODO: Show macro-recording and related messages.

(import-macros
  {: bind! : bufln : statusln3 : winbar} :lua.soup.plugins.ui.heirline.macros
  {: modcall : nonnil} :soupmacs.soupmacs)

(fn fetch-colors []
  "Fetches and returns the colors to be loaded by Heirline."
  (let
    [ {:get_highlight hl} (require :heirline.utils)
      comment* (hl :Comment)
      constant (hl :Constant)
      error (hl :DiagnosticError)
      hint (hl :DiagnosticHint)
      identifier (hl :Identifier)
      info (hl :DiagnosticInfo)
      normal (hl :Normal)
      search (hl :Search)
      special (hl :Special)
      statement (hl :Statement)
      statusline (hl :StatusLine)
      string (hl :String)
      tabline (hl :TabLine)
      tablinesel (hl :TabLineSel)
      type (hl :Type)
      warn (hl :DiagnosticWarn)
      winbar* (hl :WinBar)
      winbarnc (hl :WinBarNC)]
    { ; Modes
      :n normal.fg
      :no comment*.fg
      :nov comment*.fg
      :noV comment*.fg
      "no\22" comment*.fg
      :niI normal.fg 
      :niR normal.fg 
      :niV normal.fg 
      :nt normal.fg 
      :ntT normal.fg 
      :v search.fg
      :vs search.fg
      :V search.fg
      :Vs search.fg
      "\22" search.fg
      "\22s" search.fg
      :s hint.fg
      :S hint.fg
      "\19" hint.fg
      :i string.fg
      :ic string.fg
      :ix string.fg
      :R special.fg
      :Rc special.fg
      :Rx special.fg
      :Rv special.fg
      :Rvc special.fg
      :Rvx special.fg
      :c statement.fg
      :cv error.fg
      :r identifier.fg
      :rm identifier.fg
      :r? identifier.fg
      :! error.fg
      :t type.fg

      ; Misc
      :buflocked error.fg
      :bufmod hint.fg
      :diagnerr error.fg
      :diagnwarn warn.fg
      :diagninfo info.fg
      :diagnhint hint.fg
      :filecn constant.fg
      :fileenc special.fg
      :filefmt string.fg
      :fileln warn.fg
      :githead type.fg
      :scroll error.fg
      :statuslinebg statusline.bg
      :statuslinefg statusline.fg
      :tablinebg tabline.bg
      :tablinefg tabline.fg
      :tablineselbg tablinesel.bg
      :tablineselfg tablinesel.fg
      :termcmd type.fg
      :termcwd special.fg
      :termpid identifier.fg
      :winbarbg winbar*.bg
      :winbarfg winbar*.fg
      :winbarncbg winbarnc.bg
      :winbarncfg winbarnc.fg}))

(fn config []
  "Post-load configuration hook."

  (fn setup-lines []
    "Sets up the status lines."
    (let
      [ api vim.api
        devicons (require :nvim-web-devicons)
        heirline-conditions (require :heirline.conditions)
        heirline-utils (require :heirline.utils)
        (L*-normal L*-comment L*-linenr)
        (let
          [ convert (require :ccc.utils.convert)
            {: hex} (require :ccc.utils.parse)
            {: str} (require :ccc.output.hex)
            hex->rgb
            (fn [hexcolor]
              "Converts `hexcolor` to a RGB color table."
              (let
                [ (_ _ r g b) (hexcolor:find "^#(%x%x)(%x%x)(%x%x)$")
                  rgb [r g b]
                  rgb (icollect [_ c (ipairs rgb)] (hex c))]
                rgb))
            L*
            (fn [L* hexcolor]
              "Normalizes `hexcolor`'s lightness to `L*`.
        
              `hexcolor` is a color in the format `#RRGGBB`, while `L*` is a
              number between 0 and 100 representing the L*a*b*'s lightness."
              (let
                [ rgb (hex->rgb hexcolor)
                  lab (convert.rgb2lab rgb)
                  lab [L* (unpack lab 2)]
                  rgb (convert.lab2rgb lab)
                  hex (str rgb)]
                hex))
            hl heirline-utils.get_highlight
            hl-L*
            (fn [group]
              "Returns the L*a*b*'s lightness for highlight of `group`."
              (->
                (-> :#%x (: :format (-> (hl group) (. :fg))))
                (hex->rgb)
                (convert.rgb2lab)
                (. 1)))
            L*-normal (hl-L* :Normal)
            L*-comment (hl-L* :Comment)
            L*-linenr (hl-L* :LineNr)]
          (values
            (partial L* L*-normal)
            (partial L* L*-comment)
            (partial L* L*-linenr)))
        space {:provider " "}]
      (bind!
        { :vim-api api
          : devicons
          : heirline-conditions
          : heirline-utils
          : L*-normal
          : L*-comment
          : L*-linenr
          : nonnil
          :statusline-space space})
      (modcall
        :heirline
        :setup
        { :statusline (statusln3)
          :winbar (winbar)
          :tabline (heirline-utils.make_buflist (bufln))})
      (set vim.opt.showtabline 2)))

  (let
    [ colors (fetch-colors)
      api vim.api
      group
      (api.nvim_create_augroup :soup.plugins.ui.heirline.def-hl {:clear true})]
    (modcall :heirline :load_colors colors)
    (setup-lines)
    (api.nvim_create_autocmd
      :ColorScheme
      { :desc "Defines highlight colors for Heirline."
        : group
        :callback
        #(let [colors (fetch-colors)]
          (modcall :heirline.utils :on_colorscheme colors))})
    ; FIXME: When writing an unnamed buffer it doesn't get triggered.
    (api.nvim_create_autocmd
      :User
      { :desc "Sets whether the window bar is enabled."
        : group
        :pattern :HeirlineInitWinbar
        :callback
        #(when
          (modcall
            :heirline.conditions
            :buffer_matches
            { :buftype [:nofile :prompt :quickfix]
              :filetype [:neo-tree :packer]})
          (set vim.opt_local.winbar nil))})))

{ 1 :rebelot/heirline.nvim
  :event "User SoupHasColors"
  : config
  :dependencies [:ccc.nvim :kyazdani42/nvim-web-devicons]}
