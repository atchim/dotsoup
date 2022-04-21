(import-macros {: calls} :fnl.soup.macros)

(fn init []
  (calls :init :soup
    :core
    :plugins))

{: init}
