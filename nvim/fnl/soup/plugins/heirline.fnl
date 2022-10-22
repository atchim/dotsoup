; TODO: Add support for working directory.
; TODO: Add support for terminal.
; TODO: Add support for Git.
; TODO: Add support for LSP.
; TODO: Hide window bar if buffer is unlisted or scratch.

(import-macros {: call} :fnl.soup.macros)

(fn config []
  (call :soup.plugins.heirline :setup)
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
            (call :soup.plugins.heirline :setup)
            (call :heirline :reset_highlights))})
    (api.nvim_create_autocmd :User
      { : group
        :pattern :HeirlineInitWinbar
        :desc "Sets whether the window bar is enabled."
        :callback
          (fn [args]
            (if
              (call :heirline.conditions :buffer_matches
                { :buftype [:nofile :prompt :quickfix]
                  :filetype [:neo-tree :packer]})
              (set vim.opt_local.winbar nil)))})))

(fn setup []
  "Setups the status line and window bar."

  (local api vim.api)
  (local bo vim.bo)
  (local f vim.fn)
  (local o vim.o)

  (local
    { :is_active active?
      :width_percent_below w%<?}
    (require :heirline.conditions))
  (local
    { :get_highlight get-hl
      : insert}
    (require :heirline.utils))
  (local {:get_icon_color get-icon} (require :nvim-web-devicons))

  ; Highlight definitions from builtin groups.
  (local hl
    { :err (get-hl :DiagnosticError)
      :hint (get-hl :DiagnosticHint)
      :normal (get-hl :Normal)
      :search (get-hl :Search)
      :special (get-hl :Special)
      :statement (get-hl :Statement)
      :status (get-hl :StatusLine)
      :statusnc (get-hl :StatusLineNC)
      :string (get-hl :String)
      :title (get-hl :Title)
      :type (get-hl :Type)
      :warn (get-hl :DiagnosticWarn)
      :winbar (get-hl :WinBar)
      :winbarnc (get-hl :WinBarNC)})

  ; Helpers
  (local align {:provider :%=})
  (local space {:provider " "})

  ; Buffer Stuff
  (local buf-init
    {:init (fn [self] (set self.name (api.nvim_buf_get_name 0)))})
  (local buf-icon
    { :hl (fn [self] {:fg self.icon_color})
      :init
        (fn [self]
          (local name self.name)
          (local ext (f.fnamemodify name ::e))
          (set (self.icon self.icon_color)
            (get-icon name ext {:default true})))
      :provider (fn [self] (when self.icon self.icon))})
  (local buf-name
    { 1 space
      2
        { :hl {:fg hl.title.fg :bold true}
          :provider
            (fn [self]
              (var name (f.fnamemodify self.name ::.))
              (when (not (w%<? (length name) 0.5))
                (set name (f.pathshorten name)))
              name)}
      :condition (fn [self] (not (= "" self.name)))})
  (local buf-flags
    [ { 1 space
        2 {:hl {:fg hl.err.fg :bold true} :provider :}
        :condition (fn [_] (not bo.modifiable))}
      { 1 space
        2 {:hl {:fg hl.warn.fg :bold true} :provider "[+]"}
        :condition (fn [_] bo.modified)}])
  (local buf (insert buf-init buf-icon buf-flags buf-name))

  ; File Enconding and Format
  (local file
    [ { :init
          (fn [self]
            (set self.enc (or (when (not (= "" bo.fenc)) bo.fenc) o.enc)))
        :provider
          (fn [self] (when (not (= self.enc :utf-8)) (self.enc:upper)))}
      space
      { :init (fn [self] (set self.fmt bo.fileformat))
        :provider
          (fn [self] (when (not (= :unix self.fmt)) (self.fmt:upper)))}])

  ; Ruler
  (local ruler {:provider :%l:%c})

  ; Scroll
  (local scroll
    { :provider
        (fn [self]
          (local line (. (api.nvim_win_get_cursor 0) 1))
          (local lines (api.nvim_buf_line_count 0))
          (local i
            (->
              (/ line lines)
              (* (- (length self.bar) 1))
              (+ 1)
              (math.floor)))
          (. self.bar i))
      :static {:bar [:█ :▇ :▆ :▅ :▄ :▃ :▂ :▁]}})

  ; VI Mode
  (local vimode
    { :hl
        (fn [self]
          { :fg (. self.colors (self.mode:sub 1 1))
            :bold true
            :reverse true})
      :init (fn [self] (set self.mode (f.mode 1)))
      :provider
        (fn [self] (.. "%-0.3(  %)%-3.4(" (. self.modes self.mode) " %)"))
      :static
        { :colors
            { :c hl.statement.fg
              :i hl.string.fg
              :n hl.normal.fg
              :r hl.hint.fg
              :R hl.warn.fg
              :s hl.special.fg
              :S hl.special.fg
              "" hl.special.fg
              :t hl.type.fg
              :v hl.search.bg
              :V hl.search.bg
              "" hl.search.bg
              :! hl.err.fg}
          :modes
            { :c :C
              :cv :CV
              :i :I
              :ic :IC
              :ix :IX
              :n :N
              :niI :NI
              :niR :NR
              :niV :NV
              :no :N?
              :nov :N?
              :noV :N?
              "no" :N?
              :nt :NT
              :r :...
              :rm :M
              :r? :?
              :R :R
              :Rc :RC
              :Rv :RV
              :Rvc :RVC
              :Rvx :RVX
              :Rx :RX
              :s :S
              :S :S_
              "" :^S
              :t :T
              :v :V
              :vs :VS
              :V :V_
              :Vs :V_S
              "" :^V
              "s" :^VS
              :! :!}}
      :update :ModeChanged})

  ; Status Line
  (local def
    [vimode space buf align file space ruler space scroll space])
  (local nc
    { 1 (unpack [space buf align file space ruler space scroll space])
      :condition (fn [_] (not (active?)))
      :hl {1 (unpack hl.statusnc) :force true}})
  (local statusline
    { 1 (unpack [nc def])
      :hl (fn [_] (if (active?) hl.status hl.statusnc))
      :fallthrough false})

  ; Window Bar
  (local def [space buf])
  (local nc
    { 1 (unpack [space buf])
      :condition (fn [_] (not (active?)))
      :hl {1 (unpack hl.winbarnc) :force true}})
  (local winbar
    { 1 (unpack [nc def])
      :hl (fn [_] (if (active?) hl.winbar hl.winbarnc))
      :fallthrough false})

  (call :heirline :setup statusline winbar))

{ : config
  : setup}
