require("config")
require("remap") -- load the keys before lazy
require("config.lazy")
require("plugins.telescope")

vim.cmd('silent! colorscheme gruvbox')
vim.cmd('silent! set clipboard+=unnamedplus')

