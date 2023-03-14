(fn opts []
  (local dashboard (require :alpha.themes.dashboard))

  (local art
    [ " ▓ ▓ ▓▓ ▓▓ ▓▓▓                  ░░░░░░  ░░░░"
      "░▓░▓░▓▓░▓▓░▓░▓                ░▒▒▒▒▒▒▒░▒▒▒▒▒░░"
      "░▓░▓░▓░▓░▓░▓▓▓               ░▒▒▒▒▒░░░░░░▒░░▒▒▒░"
      "░▓▓▓░▓░▓░▓░▓░▓              ░▒▒▒▒▒░▒▒▒▒▒▒░▒▒▒▒▒▒░"
      "░░░ ░ ░ ░ ░ ░             ░▒▒░░▒▒▒▓░▒▓▓▒▓▓░▒░▒▓▒░▓░"
      " ▓▓  ▓    ▓▓ ▓          ░▒▒▒░▓▓░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░"
      "░▓ ▓░▓   ▓░ ░▓        ░▒▒▒▒▒░▓▒▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▒▒▒▒▒░"
      "░▓░▓░▓  ░▓  ░        ░▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓░░░█▒▓▓▒░░▓█▒"
      "░▓▓ ░▓▓▓░ ▓▓ ▓     ░▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▒▓▒▒▒▓▒▓▒▒▓▓▒▒░"
      "░░  ░░░  ░░ ░    ░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▒▒▓▓▒░"
      "           ▓   ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▒▒▓░▒░▓▒▓▓▓▓▓░"
      "          ░  ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▒░▒▓▓▓▒▓▓▓▓▓▓▓▓▒▓▓▒▒░"
      "            ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▒░░░▒▒▒▒▒▒▒▒▒▒▒░░░░"
      "           ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▒▓░░░░░░░░░░░▒▒▒░"
      "          ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▓▒▒▒▒▒▒▒▓▒▒▒▓▒▓░"
      "         ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▓▓▒▓▓░▓░▓░▒▓░▓▒▓▒▓▒▓▒▓▒░"
      "        ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▓▓▓▓▓▓▓░▓▓░▓░▓▒▓▓▓▓▓▓▓▒░"
      "       ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░▒░▓▓▓▓▓▓░▒░▒░▒▒▓▓▓▓▓░▒▒░"
      "      ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░▒▒▒▒░░░░░▒▒▒▒▒▒░ ▒░░▒▒▒▒░"
      "     ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░  ░▒▒▒▒▒"
      "    ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░ ░▒▒▒▒▒░"
      "    ░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒░"
      "   ░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░"])
  (set dashboard.section.header.val art)

  (set dashboard.section.buttons.val
    [ (dashboard.button :e "  New file" ":ene <BAR> startinsert<CR>")
      (dashboard.button :f "  Find files" ":Telescope find_files<CR>")
      (dashboard.button :g "  Live grep" ":Telescope live_grep<CR>")
      (dashboard.button :o "  Recent files" ":Telescope oldfiles<CR>")
      (dashboard.button :l "󰒲  Lazy" ::Lazy<CR>)
      (dashboard.button :m "🧱 Mason" ::Mason<CR>)
      (dashboard.button :q "  Quit" ":qa<CR>")])

  (each [_ button (ipairs dashboard.section.buttons.val)]
    (set button.opts.hl :String)
    (set button.opts.hl_shortcut :Statement))
  (set dashboard.section.header.opts.hl :Constant)
  
  dashboard.opts)

{ 1 :goolord/alpha-nvim
  :name :alpha
  :event :VimEnter
  : opts
  :config true
  :dependencies :kyazdani42/nvim-web-devicons}
