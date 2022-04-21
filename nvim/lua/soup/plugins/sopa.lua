local function config()
  local config0 = require("sopa.config")
  config0.enabled_plugins = {"bufferline", "leap", "neo-tree", "treesitter"}
  return nil
end
return {config = config}
