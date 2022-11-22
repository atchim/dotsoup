local M = {}
M.config = function()
  local config = {use_winbar = "smart", selection_chars = "JKFLAHDSG"}
  return (require("window-picker")).setup(vim.tbl_deep_extend("force", config, (require("sopa.integrations.window-picker")).colors))
end
return M
