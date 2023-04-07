local plugins = {
  "rebelot/kanagawa.nvim",
  "airblade/vim-gitgutter", 
  "tpope/vim-fugitive",
  "nvim-telescope/telescope.nvim",
  "nvim-lua/plenary.nvim",
  "folke/which-key.nvim",
  "nvim-lualine/lualine.nvim",
  "goolord/alpha-nvim",
  "smjonas/live-command.nvim",
  "numToStr/FTerm.nvim",
  "ThePrimeagen/vim-be-good",
  { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
  'neovim/nvim-lspconfig',
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(plugins)
