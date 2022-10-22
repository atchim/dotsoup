; TODO: Hide Bufferline if there are less than 2 listed buffers.
; TODO: Do not show the close button.

(import-macros {: call} :fnl.soup.macros)

(fn config []
  (call :bufferline :setup
    { :options
        { :diagnostics :nvim_lsp
          :numbers #(.. $1.id " ")
          :separator_style ["" ""]
          :themable true}}))

{: config}
