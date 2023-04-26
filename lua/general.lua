vim.opt.showmode = false
vim.opt.scrolloff = 8


vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

local TAB_WIDTH = 2
vim.o.expandtab = true
vim.o.tabstop = TAB_WIDTH
vim.o.shiftwidth = TAB_WIDTH


vim.cmd("set listchars=tab:>>,trail:~,extends:>,precedes:<,space:·")
vim.cmd("set list")
vim.cmd("set autoread")
vim.cmd("set signcolumn=yes")

vim.g.loaded_matchparen = 1
