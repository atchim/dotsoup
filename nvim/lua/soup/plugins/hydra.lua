local function config()
  local hydra = require("hydra")
  return hydra({name = "Window", body = "<C-W>", heads = {{"+", "<C-W>+"}, {"-", "<C-W>-"}, {"<", "<C-W><lt>"}, {">", "<C-W><gt>"}, {"H", "<C-W>H"}, {"J", "<C-W>J"}, {"K", "<C-W>K"}, {"L", "<C-W>L"}, {"_", "<C-W>_"}, {"h", "<C-W>h"}, {"j", "<C-W>j"}, {"k", "<C-W>k"}, {"l", "<C-W>l"}, {"q", "<C-W>q"}, {"s", "<C-W>s"}, {"v", "<C-W>v"}, {"w", "<C-W>w"}, {"x", "<C-W>x"}, {"|", "<C-W>|"}}})
end
return {config = config}
