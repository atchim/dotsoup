local function config()
  local config0 = {selection_chars = "JKFLAHDSG"}
  local function _2_()
    local t_1_ = require("sopa.plugins.window-picker")
    if (nil ~= t_1_) then
      t_1_ = (t_1_).colors
    else
    end
    return t_1_
  end
  return (require("window-picker")).setup(vim.tbl_deep_extend("force", config0, _2_()))
end
return {config = config}
