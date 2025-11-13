-- Make sure to setup `mapleader` and `maplocalleader` before
-- The mapleader is the first key to press for custom keybinds (default is \, now it's 'space')
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Lazy plugin manager loader (leader is defined there)
require("config.lazy")

-- Handles custom keybinds.
require("config.keymaps")

-- Colorscheme
vim.cmd.colorscheme "tokyonight-night"

-- Numbers on the side
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Tabulation config
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Colors the column on the right
vim.opt.colorcolumn = "80"

-- Makes the mouse usable in nvim
vim.opt.mouse = 'a'

-- Vsplit now opens on the right
vim.opt.splitright = true

-- Settings needed for the tree which disables nvim default tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Allows 24bit rgb colors
vim.opt.termguicolors = true

-- Makes line wrapping respect the indentation
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
--vim.opt.breakindentopt = { "shift:2" }

-- Space between cursor and bottom+side of screen
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- Case insensitive search + case sensitive if capital letter
vim.o.ignorecase = true
vim.o.smartcase = true

