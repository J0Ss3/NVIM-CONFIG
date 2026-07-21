-- ~/.config/nvim/lua/plugins/colorscheme.lua
-- Tema de color: Ayu (https://github.com/Shatur/neovim-ayu)

return {
  {
    "Shatur/neovim-ayu",
    priority = 1000, -- cargar antes que el resto de plugins
    config = function()
      require("ayu").setup({
        -- Variantes: "dark" (por defecto), "mirage" (dark suave), "light"
        mirage = false, -- pon esto en true si prefieres "mirage" en vez de "dark"
        terminal = true, -- deja que el tema controle los colores del :terminal

        -- Aquí puedes sobreescribir grupos de resaltado si algo no te gusta.
        -- Ejemplo (descomenta si quieres desactivar cursiva en comentarios):
        -- overrides = {
        --   Comment = { italic = false },
        -- },
        overrides = {},
      })

      vim.cmd.colorscheme("ayu")
    end,
  },
}
