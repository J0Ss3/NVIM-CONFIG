-- ~/.config/nvim/lua/config/keymaps.lua
-- Atajos de teclado globales (los de LSP están en lua/plugins/lsp.lua)

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Mejor experiencia de movimiento
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- Guardar y salir rápido
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Guardar archivo" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Cerrar ventana" })

-- Navegación entre ventanas (splits)
map("n", "<C-h>", "<C-w>h", { desc = "Ir a la ventana izquierda" })
map("n", "<C-l>", "<C-w>l", { desc = "Ir a la ventana derecha" })
map("n", "<C-j>", "<C-w>j", { desc = "Ir a la ventana inferior" })
map("n", "<C-k>", "<C-w>k", { desc = "Ir a la ventana superior" })

-- Mover líneas seleccionadas en modo visual
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Mantener el cursor centrado al buscar
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- Limpiar resaltado de búsqueda
map("n", "<leader>nh", "<cmd>nohlsearch<CR>", { desc = "Quitar resaltado de búsqueda" })

-- Telescope (buscador difuso)
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Buscar archivos" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Buscar texto en el proyecto" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buscar buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Buscar en la ayuda" })

-- Explorador de archivos (neo-tree)
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Alternar explorador de archivos" })
