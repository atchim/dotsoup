local function config()
  local function _1_(_241)
    return (_241.id .. " ")
  end
  return (require("bufferline")).setup({options = {numbers = _1_, separator_style = {"", ""}, themable = true}})
end
return {config = config}
