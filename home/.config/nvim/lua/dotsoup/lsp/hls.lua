local function setup(lsp)
  lsp.hls.setup({on_attach = require('dotsoup.lsp').on_attach})
end

return {setup = setup}
