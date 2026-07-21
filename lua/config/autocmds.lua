-- ~/.config/nvim/lua/config/autocmds.lua
-- Autocomandos generales

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local general = augroup("GeneralSettings", { clear = true })

-- Resaltar el texto copiado brevemente
autocmd("TextYankPost", {
  group = general,
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- Restaurar la posición del cursor al abrir un archivo
autocmd("BufReadPost", {
  group = general,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Quitar espacios en blanco al final de línea antes de guardar
autocmd("BufWritePre", {
  group = general,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Recargar el archivo automáticamente si cambió fuera de Neovim
autocmd({ "FocusGained", "BufEnter" }, {
  group = general,
  command = "checktime",
})
