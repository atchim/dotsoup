local function config()
  local function _1_(_241)
    return (_241.id .. " ")
  end
  return (require("bufferline")).setup({options = {diagnostics = "nvim_lsp", numbers = _1_, separator_style = {"", ""}, themable = true}})
end
return {config = config}
