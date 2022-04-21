local function init()
  return (require("soup.plugins.packer")).init()
end
return {init = init}
