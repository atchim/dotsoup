local function init()
  do end (require("soup.core")).init()
  return (require("soup.plugins")).init()
end
return {init = init}
