(import-macros {: modcall} :soupmacs.soupmacs)

(fn setup []
  "Sets up the Soup configurations."
  (modcall :soup.core :setup []))

{: setup}
