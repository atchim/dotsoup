local M = {}
M.config = function()
  local config = require("sopa.config")
  config.enabled_integrations = {"cmp", "indent-blankline", "leap", "neo-tree", "treesitter"}
  return nil
end
return M
