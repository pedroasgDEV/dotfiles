vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.lazy")

vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])
vim.opt.swapfile = false
vim.opt.termguicolors = true

-- Basic Spell Settings
vim.opt.spelllang = { 'en_us', 'pt_br' }
vim.opt.spell = false -- Começa desligado

-- Auto-enable spell check for LaTeX and Markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "tex", "latex", "markdown", "text" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- Highlight for misspelled words (Purple undercurl)
vim.api.nvim_set_hl(0, 'SpellBad', { undercurl = true, sp = '#BD93F9' })
vim.api.nvim_set_hl(0, 'SpellCap', { undercurl = true, sp = '#BD93F9' })
vim.api.nvim_set_hl(0, 'SpellLocal', { undercurl = true, sp = '#BD93F9' })
vim.api.nvim_set_hl(0, 'SpellRare', { undercurl = true, sp = '#BD93F9' })
