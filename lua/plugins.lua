local plugins = {
  "lewis6991/impatient.nvim",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",

  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",

  "stevearc/dressing.nvim",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",

  -- color theme
  { "bluz71/vim-moonfly-colors",       name = "moonfly", lazy = false, priority = 1000 },

  -- version control
  "airblade/vim-gitgutter",
  "tpope/vim-fugitive",

  -- navigation
  "nvim-telescope/telescope.nvim",
  "nvim-lua/plenary.nvim",
  "folke/which-key.nvim",
  "nvim-lualine/lualine.nvim",
  "goolord/alpha-nvim",
  "tpope/vim-repeat",
  "tpope/vim-unimpaired",

  -- tools
  "tpope/vim-surround",
  "tpope/vim-commentary",
  "tpope/vim-eunuch",
  "qpkorr/vim-renamer",
  "smjonas/live-command.nvim",
  "ThePrimeagen/vim-be-good",
  "dstein64/vim-startuptime",
  "github/copilot.vim",

  -- languages
  { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
  "nvim-treesitter/nvim-treesitter-context",
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
