vim.opt.showmode = false
vim.opt.scrolloff = 8


vim.g.mapleader = ' '
vim.o.guifont = 'Cascadia Code:h12'

vim.opt.number = true
vim.opt.relativenumber = true

local TAB_WIDTH = 2
vim.o.expandtab = true
vim.o.tabstop = TAB_WIDTH
vim.o.shiftwidth = TAB_WIDTH
vim.o.shortmess = 'I'

vim.opt.listchars = {tab = '>>', trail = '~', extends = '>', precedes = '<', space = '·'}
vim.opt.list = false
vim.opt.autoread = true
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true

vim.g.loaded_matchparen = 1
