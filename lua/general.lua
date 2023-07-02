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

vim.g.moonflyVirtualTextColor = true
vim.g.moonflyUnderlineMatchParen = true
vim.g.moonflyWinSeparator = 2
vim.opt.fillchars = { horiz = '━', horizup = '┻', horizdown = '┳', vert = '┃', vertleft = '┫', vertright = '┣', verthoriz = '╋', }

-- useState
vim.keymap.set("n", "<BS>s", ":norm viw\"9y<CR>:norm iconst [<CR>:norm A, <CR>:norm \"9pb~<CR>:norm hiset<CR>:norm A] = useState()<CR>:norm h<CR>", { silent = true })

-- useEffect
vim.keymap.set("n", "<BS>e", ":norm IuseEffect(() => {<CR>:norm o}, [])<CR>:norm O<Tab><CR>", { silent = true })

-- vim.g.loaded_matchparen = 1

