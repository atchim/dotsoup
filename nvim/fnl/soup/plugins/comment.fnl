(import-macros {: call} :fnl.soup.macros)

(fn config []
  (call :Comment :setup
    { :opleader {:block :gC}
      :padding false
      :toggler {:block :gcC}}))

{: config}
