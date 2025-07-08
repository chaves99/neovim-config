require("config")
require("remap") -- load the keys before lazy
require("config.lazy")
require("plugins.telescope")

vim.cmd('silent! colorscheme gruvbox-material')
vim.cmd('silent! set clipboard+=unnamedplus')

