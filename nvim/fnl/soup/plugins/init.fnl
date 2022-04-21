(import-macros {: call} :fnl.soup.macros)

(fn init []
  "Set plugin configurations."
  (call :soup.plugins.packer :init))

{: init}
