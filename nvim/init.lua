vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.lazy")

vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])
vim.opt.swapfile = false
vim.opt.termguicolors = true

vim.lsp.set_log_level("ERROR")
vim.diagnostic.config({ update_in_insert = false, })
