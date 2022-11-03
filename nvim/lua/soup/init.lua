local M = {}
M.init = function()
  do end (require("soup.core")).init()
  return (require("soup.plugins")).init()
end
return M
