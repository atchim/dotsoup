(import-macros {: call} :fnl.soup.macros)

(fn config []
  (call :heirline :setup (call :soup.plugins.heirline :statusline))
  (let
    [ api vim.api
      group (api.nvim_create_augroup :soup_plugin_heirline {})]
    (api.nvim_create_autocmd :ColorScheme
      { : group
        :desc "Update colors for the status line on color scheme change."
        :callback
          #(let
            [ {: statusline} (require :soup.plugins.heirline)
              {: reset_highlights : setup} (require :heirline)]
            (setup (statusline))
            (reset_highlights))})))

(fn statusline []
  "Return built status line."

  (local api vim.api)
  (local bo vim.bo)
  (local f vim.fn)
  (local o vim.o)

  (local
    { :is_active active?
      :width_percent_below wpb}
    (require :heirline.conditions))
  (local
    { :get_highlight get-hl
      : insert
      :pick_child_on_condition pcod}
    (require :heirline.utils))
  (local {:get_icon_color get-icon} (require :nvim-web-devicons))

  ; Highlight definitions from builtin groups.
  (local hl
    { :dir (get-hl :Directory)
      :err (get-hl :DiagnosticError)
      :hint (get-hl :DiagnosticHint)
      :normal (get-hl :Normal)
      :search (get-hl :Search)
      :special (get-hl :Special)
      :statement (get-hl :Statement)
      :status (get-hl :StatusLine)
      :statusnc (get-hl :StatusLineNC)
      :string (get-hl :String)
      :type (get-hl :Type)
      :warn (get-hl :DiagnosticWarn)})

  ; Helpers
  (local align {:provider :%=})
  (local space {:provider " "})

  ; Buffer Stuff
  (local buf {:init (fn [self] (set self.name (api.nvim_buf_get_name 0)))})
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
        { :hl {:fg hl.dir.fg :bold true}
          :provider
            (fn [self]
              (var name (f.fnamemodify self.name ::.))
              (when (not (wpb (length name) 0.5))
                (set name (f.pathshorten name)))
              name)}
      :condition (fn [self] (not (= "" self.name)))})
  (local buf-flags
    [ { 1 space
        2 {:hl {:fg hl.err.fg :bold true} :provider :}
        :condition (fn [_] (not bo.modifiable))}
      { 1 space
        2 {:hl {:fg hl.warn.fg :bold true} :provider :+}
        :condition (fn [_] bo.modified)}])
  (local buf (insert buf buf-icon buf-flags buf-name))

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
      :provider (fn [self] (.. "  %-3.3(" (. self.modes self.mode) "%) "))
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
              :! :!}}})

  ; Status Line
  (local def [vimode space buf align file space ruler space scroll space])
  (local nc
    { 1 (unpack [space buf align file space ruler space scroll space])
      :condition (fn [_] (not (active?)))
      :hl {1 (unpack hl.statusnc) :force true}})
  (local statusline
    { 1 nc 2 def
      :hl (fn [_] (if (active?) hl.status hl.statusnc))
      :init pcod})
  statusline)

{ : config
  : statusline}
