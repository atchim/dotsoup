local M = {}
M.init = function()
  do end (require("soup.core.g")).init()
  do end (require("soup.core.opts")).init()
  do end (require("soup.core.maps")).init()
  do end (require("soup.core.cmds")).init()
  do end (require("soup.core.au")).init()
  return (require("soup.core.diagnostics")).init()
end
return M
