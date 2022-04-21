(import-macros {: call} :fnl.soup.macros)

(fn config []
  (call :harpoon :setup
    {:global_settings {:enter_on_sendcmd true}})

  (let
    [ term (if (vim.fn.exists :$TMUX) :tmux :term)
      fmt string.format]
    (macro sendcmd [n]
      "Expand to a list with both the `sendCommand` command and their
      description."
      `[(fmt "<Cmd>lua require'harpoon'.%s.sendCommand(1, %d)<CR>" term ,n)
        ,(.. "Send command #" n)])
    (macro navfile [n]
      "Expand to a list with both the `nav_file` command and their
      description."
      `[,(.. "<Cmd>lua require'harpoon.ui'.nav_file(" n ")<CR>")
        ,(.. "Go to file #" n)])
    (call :which-key :register
      { "[j"
          [ "<Cmd>lua require'harpoon.ui'.nav_prev()<CR>"
            "Harpoon go to previous mark"]
        "]j"
          [ "<Cmd>lua require'harpoon.ui'.nav_next()<CR>"
            "Harpoon go to next mark"]
        :j
          { :name :Harpoon
            :0 (navfile 10)
            :1 (navfile 1)
            :2 (navfile 2)
            :3 (navfile 3)
            :4 (navfile 4)
            :5 (navfile 5)
            :6 (navfile 6)
            :7 (navfile 7)
            :8 (navfile 8)
            :9 (navfile 9)
            :a
              [ "<Cmd>lua require'harpoon.mark'.add_file()<CR>"
                "Harpoon push current file"]
            :j
              [ "<Cmd>lua require'harpoon.ui'.toggle_quick_menu()<CR>"
                "Harpoon toggle quick menu"]
            :t
              [ (.. "<Cmd>lua require'harpoon." term "'.gotoTerminal(1)<CR>")
                "Harpoon go to terminal"]
            :c
              { :name :Commands
                :0 (sendcmd 10)
                :1 (sendcmd 1)
                :2 (sendcmd 2)
                :3 (sendcmd 3)
                :4 (sendcmd 4)
                :5 (sendcmd 5)
                :6 (sendcmd 6)
                :7 (sendcmd 7)
                :8 (sendcmd 8)
                :9 (sendcmd 9)
                :c
                  [ "<Cmd>lua require'harpoon.cmd-ui'.toggle_quick_menu()<CR>"
                    "Harpoon toggle command quick menu"]}}}
      {:prefix :<Leader>})))

{: config}
