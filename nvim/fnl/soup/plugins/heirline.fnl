(import-macros
  {: bo : buf} :fnl.soup.plugins.heirline-macros
  {: modcall} :soupmacs.soupmacs)

(local M {})

(fn M.init []
  "Sets the status line, buffer line and window bar."

  (local api vim.api)
  (local tbldx vim.tbl_deep_extend)

  (local
    {:is_active active? :width_percent_below w%<?}
    (require :heirline.conditions))

  (local
    {:get_highlight get-hl : insert :make_buflist mkbufls}
    (require :heirline.utils))

  (local hl
    { :comment (get-hl :Comment)
      :const (get-hl :Constant)
      :dir (get-hl :Directory)
      :err (get-hl :DiagnosticError)
      :hint (get-hl :DiagnosticHint)
      :info (get-hl :DiagnosticInfo)
      :normal (get-hl :Normal)
      :num (get-hl :Number)
      :preproc (get-hl :Preproc)
      :search (get-hl :Search)
      :special (get-hl :Special)
      :status (get-hl :StatusLine)
      :string (get-hl :String)
      :tabline (get-hl :TabLine)
      :tablinesel (get-hl :TabLineSel)
      :title (get-hl :Title)
      :ty (get-hl :Type)
      :warn (get-hl :DiagnosticWarn)
      :winbar (get-hl :Winbar)
      :winbarnc (get-hl :WinbarNC)})

  (local align {:provider :%=})
  (local space {:provider " "})

  (local statusln
    (let
      [ file
        [ { :init
            (fn [self]
              (set self.enc
                (or (when (not= vim.bo.fenc "") vim.bo.fenc) vim.o.enc)))
            :provider (fn [self] self.enc)
            :hl {:fg hl.comment.fg}}
          space
          { :init (fn [self] (set self.fmt vim.bo.fileformat))
            :provider (fn [self] (match self.fmt :dos : :mac : :unix :))
            :hl {:fg hl.ty.fg}}]
        git
        { :condition
          (fn [self]
            (let [head (or vim.b.gitsigns_head ghead vim.g.gitsigns_head)]
              (when head (set self.head head) true)))
          :provider (fn [self] (.. : " " self.head " "))
          :hl {:fg hl.ty.fg}}
        ruler
        (let
          [ proto
            { :init
              (fn [self]
                (when (not self.once)
                  (api.nvim_create_autocmd
                    :CursorMoved
                    {:pattern :*:*o :command :redrawstatus})
                  (set self.once true)))}
            ln {:provider :%l :hl {:fg hl.num.fg}}
            col {:provider :%c :hl {:fg hl.const.fg}}]
          (insert proto ln space col))
        scroll
        { :static {:bar [:█ :▇ :▆ :▅ :▄ :▃ :▂ :▁]}
          :provider
          (fn [self]
            (let
              [ line (. (api.nvim_win_get_cursor 0) 1)
                lines (api.nvim_buf_line_count 0)
                i
                  (->
                    (/ line lines)
                    (* (- (length self.bar) 1))
                    (+ 1)
                    (math.floor))]
              (. self.bar i)))}
        vimode
        { :static
          { :colors
            { "\19" hl.special.fg
              "\22" hl.search.bg
              :! hl.err.fg
              :c hl.preproc.fg
              :i hl.string.fg
              :n hl.normal.fg
              :r hl.warn.fg
              :R hl.hint.fg
              :s hl.special.fg
              :S hl.special.fg
              :t hl.ty.fg
              :v hl.search.bg
              :V hl.search.bg}
            :modes
            { :n :N
              :no :N?
              :nov :NV?
              :noV :NV_?
              "no\22" :NV#?
              :niI :N>I
              :niR :N>R
              :niV :N>V
              :nt "N@T"
              :ntT :N>T
              :v :V
              :vs :V<S
              :V :V_
              :Vs :V_<S
              "\22" :V#
              "\22s" :V#<S
              :s :S
              :S :S_
              "\19" :S#
              :i :I
              :ic :IC
              :ix :IX
              :R :R
              :Rc :RC
              :Rx :RX
              :Rv :RV
              :Rvc :RVC
              :Rvx :RVX
              :c :CMD
              :cv :EX
              :r "<CR>"
              :rm :...
              :r? :?
              :! :!
              :t :T}}
          :init
          (fn [self]
            (set self.mode (vim.fn.mode 1))
            (when (not self.once)
              (api.nvim_create_autocmd
                :ModeChanged
                {:pattern :*:*o :command :redrawstatus})
              (set self.once true)))
          :provider
          (fn [self] (.. "%-0.3(  %)%-5.5(" (. self.modes self.mode) " %)"))
          :hl
          (fn [self] {:fg (. self.colors (self.mode:sub 1 1)) :reverse true})
          :update :ModeChanged}]
      { 1
        (unpack
          [ vimode
            space
            git
            (buf {:cwd? true})
            align
            file
            space
            ruler
            space
            scroll
            space])
        :hl hl.status}))

  (local winbar
    { 1 (unpack [space (buf {:cwd? true})])
      :hl
      (fn [_]
        (if (active?) hl.winbar (tbldx :force hl.winbarnc {:force true})))})

  ; TODO: Avoid duplicate file names.
  (local bufln
    (let
      [ proto
        { :init
          (fn [self]
            (set self.name (api.nvim_buf_get_name self.bufnr))
            (set self.type (bo :buftype {:bufnr? true} self)))
          :hl
          (fn [self]
            (if (or self.is_active self.is_visible)
              hl.tablinesel
              (tbldx :force hl.tabline {:force true})))
          :on_click
          { :minwid (fn [self] self.bufnr)
            :callback
            (fn [_ minwid _ button]
              (match button
                :l (api.nvim_win_set_buf 0 minwid)
                :r (api.nvim_buf_delete minwid {:force false})))
            :name :bufln_click_cb}}
        cur
        { :condition (fn [self] self.is_active)
          :provider "⏵ "
          :hl {:fg hl.special.fg}}
        nr
        { :provider (fn [self] self.bufnr)
          :hl
          (fn [self]
            { :fg
                (->
                  (if
                    (or self.is_active self.is_visible) hl.tablinesel
                    hl.tabline)
                  (. :fg))})}
        diag
        (let
          [ proto
            { :condition (fn [self] (vim.diagnostic.get self.bufnr))
              :static 
              { :has
                (fn [self severity]
                  (->>
                    {:severity (. vim.diagnostic.severity severity)}
                    (vim.diagnostic.get self.bufnr)
                    (length)
                    (< 0)))}}
            sign
              (fn [severity]
                (->
                  (vim.fn.sign_getdefined (.. :DiagnosticSign severity))
                  (. 1)
                  (. :text)))
            mksign
            (fn [key signsufx hl-group]
              { :condition (fn [self] (self:has key))
                :static {:sign (sign signsufx)}
                :provider (fn [self] self.sign)
                :hl {:fg (?. hl hl-group :fg)}})
            err (mksign :ERROR :Error :err)
            warn (mksign :WARN :Warn :warn)
            info (mksign :INFO :Info :info)
            hint (mksign :HINT :Hint :hint)]
          (insert proto err warn info hint))
        buf* (buf {:bufnr? true :short? true})]
      (mkbufls (insert proto space cur nr space diag buf* space))))

  (modcall :heirline :setup (statusln winbar bufln))
  (set vim.opt.showtabline 2))

(fn M.config []
  "Post-load configuration hook."
  (modcall :soup.plugins.heirline :init ())
  (let
    [ api vim.api
      group (api.nvim_create_augroup :soup_plugin_heirline {})]
    (api.nvim_create_autocmd :ColorScheme
      { : group
        :desc
        (..
          "Updates colors for the status line and the window bar on color"
          " scheme change.")
        :callback
        #(do
          (modcall :soup.plugins.heirline :init ())
          (modcall :heirline :reset_highlights ()))})
    (api.nvim_create_autocmd :User
      { : group
        :pattern :HeirlineInitWinbar
        :desc "Sets whether the window bar is enabled."
        :callback
        #(when
          (modcall
            :heirline.conditions
            :buffer_matches
            { :buftype [:nofile :prompt :quickfix]
              :filetype [:neo-tree :packer]})
          (set vim.opt_local.winbar nil))})))

M
