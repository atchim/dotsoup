local M = {}
M.init = function()
  return (require("soup.plugins.packer")).init()
end
return M
