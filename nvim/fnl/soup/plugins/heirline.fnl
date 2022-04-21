(fn config []
  (let
    [ {: statusline} (require :soup.plugins.heirline)
      {: setup} (require :heirline)]
    (setup (statusline)))
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
    { :get_highlight get-hi
      : insert
      :pick_child_on_condition pcod}
    (require :heirline.utils))
  (local {:get_icon_color get-icon} (require :nvim-web-devicons))

  ; Highlight definitions from builtin groups.
  (local hi
    { :dir (get-hi :Directory)
      :err (get-hi :DiagnosticError)
      :hint (get-hi :DiagnosticHint)
      :normal (get-hi :Normal)
      :search (get-hi :Search)
      :special (get-hi :Special)
      :statement (get-hi :Statement)
      :status (get-hi :StatusLine)
      :statusnc (get-hi :StatusLineNC)
      :string (get-hi :String)
      :type (get-hi :Type)
      :warn (get-hi :DiagnosticWarn)})

  ; Helpers
  (local align {:provider :%=})
  (local space {:provider " "})

  ; Buffer Stuff
  (local buf
    { :init (fn [self]
        (set self.name (api.nvim_buf_get_name 0)))})
  (local buf-icon
    { :hl (fn [self] {:fg self.icon_color})
      :init (fn [self]
        (let [name self.name ext (f.fnamemodify name ::e)]
          (set (self.icon self.icon_color)
            (get-icon name ext {:default true}))))
      :provider (fn [self] (when self.icon self.icon))})
  (local buf-name
    { 1 space
      2
        { :hl {:fg hi.dir.fg :style hi.dir.style}
          :provider (fn [self]
            (var name (f.fnamemodify self.name ::.))
            (when (not (wpb (length name) 0.5))
              (set name (f.pathshorten name)))
            name)}
      :condition (fn [self] (not (= "" self.name)))})
  (local buf-flags
    [ { 1 space
        2 {:hl {:fg hi.err.fg :style :bold} :provider :}
        :condition (fn [_] (not bo.modifiable))}
      { 1 space
        2 {:hl {:fg hi.warn.fg :style :bold} :provider :+}
        :condition (fn [_] bo.modified)}])
  (local buf (insert buf buf-icon buf-flags buf-name))

  ; File Enconding and Format
  (local file
    [ { :init (fn [self]
          (set self.enc (or (when (not (= "" bo.fenc)) bo.fenc) o.enc)))
        :provider (fn [self]
          (when (not (= self.enc :utf-8)) (self.enc:upper)))}
      space
      { :init (fn [self] (set self.fmt bo.fileformat))
        :provider (fn [self]
          (when (not (= :unix self.fmt)) (self.fmt:upper)))}])

  ; Ruler
  (local ruler {:provider :%l:%c})

  ; Scroll
  (local scroll
    { :provider (fn [self]
        (let
          [ line (. (api.nvim_win_get_cursor 0) 1)
            lines (api.nvim_buf_line_count 0)
            i (math.floor (+ (* (/ line lines) (- (length self.bar) 1)) 1))]
          (. self.bar i)))
      :static {:bar ["█" "▇" "▆" "▅" "▄" "▃" "▂" "▁"]}})

  ; VI Mode
  (local vimode
    { :hl (fn [self]
        { :fg (. self.colors (self.mode:sub 1 1))
          :style "bold,reverse"})
      :init (fn [self] (set self.mode (f.mode 1)))
      :provider (fn [self] (.. "  %-3.3(" (. self.modes self.mode) "%) "))
      :static
        { :colors
            { :c hi.statement.fg
              :i hi.string.fg
              :n hi.normal.fg
              :r hi.hint.fg
              :R hi.warn.fg
              :s hi.special.fg
              :S hi.special.fg
              "" hi.special.fg
              :t hi.type.fg
              :v hi.search.bg
              :V hi.search.bg
              "" hi.search.bg
              :! hi.err.fg}
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
      :hl {1 (unpack hi.statusnc) :force true}})
  (local statusline
    { 1 nc 2 def
      :hl (fn [_] (if (active?) hi.status hi.statusnc))
      :init pcod})
  statusline)

{ : config
  : statusline}
