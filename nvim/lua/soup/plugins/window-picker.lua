local M = {}
M.config = function()
  local config = {use_winbar = "smart", selection_chars = "JKFLAHDSG"}
  local function _2_()
    local t_1_ = require("sopa.integrations.window-picker")
    if (nil ~= t_1_) then
      t_1_ = (t_1_).colors
    else
    end
    return t_1_
  end
  return (require("window-picker")).setup(vim.tbl_deep_extend("force", config, _2_()))
end
return M
