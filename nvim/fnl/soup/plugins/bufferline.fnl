(import-macros {: call} :fnl.soup.macros)

(fn config []
  (call :bufferline :setup
    { ;:highlights (-> (require :sopa.plugins.bufferline) (. :highlights))
      :options
        { :numbers #(.. $1.id " ")
          :separator_style ["" ""]
          :themable true}}))

{: config}
