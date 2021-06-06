local function setup(lsp)
  lsp.pyls.setup({on_attach = require('dotsoup.lsp').on_attach})
end

return {setup = setup}
