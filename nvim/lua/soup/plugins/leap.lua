local function config()
  return (require("leap")).set_default_keymaps()
end
return {config = config}
