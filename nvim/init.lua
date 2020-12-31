local config = require'config'

config.general.setup()
config.packer.setup()
config.lsp.setup()
config.nerdtree.setup()
config.telescope.setup()
config.treesitter.setup()

require'colorizer'.setup()
