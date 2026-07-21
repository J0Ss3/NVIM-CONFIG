-- ~/.config/nvim/lua/config/lazy.lua
-- Instala y arranca lazy.nvim (gestor de plugins), luego carga lua/plugins/*.lua

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

require("lazy").setup("plugins", {
  install = { colorscheme = { "catppuccin" } },
  checker = { enabled = true, notify = false }, -- avisa de updates sin ser molesto
  change_detection = { notify = false },
})
