-- ~/.config/nvim/lua/config/options.lua
-- Opciones generales del editor

local opt = vim.opt
local g = vim.g

-- Líder
g.mapleader = " "
g.maplocalleader = " "

-- Interfaz
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.wrap = false
opt.splitright = true
opt.splitbelow = true

-- Indentación
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Búsqueda
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Archivos y backups
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.expand("~/.local/share/nvim/undodir")

-- Rendimiento
opt.updatetime = 250
opt.timeoutlen = 400

-- Portapapeles del sistema
opt.clipboard = "unnamedplus"

-- Barra de estado mínima (la completa la da un plugin)
opt.showmode = false

-- Codificación
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Completado
opt.completeopt = { "menu", "menuone", "noselect" }
