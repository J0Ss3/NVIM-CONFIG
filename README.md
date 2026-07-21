# Configuración de Neovim

Config modular basada en `lazy.nvim`, con tema **Catppuccin** (mocha) y soporte LSP completo.

## Estructura

```
nvim/
├── init.lua                     # Punto de entrada, carga todo lo demás
└── lua/
    ├── config/
    │   ├── options.lua          # Opciones generales del editor
    │   ├── keymaps.lua          # Atajos de teclado globales
    │   ├── autocmds.lua         # Autocomandos
    │   └── lazy.lua             # Bootstrap del gestor de plugins
    └── plugins/
        ├── colorscheme.lua      # Tema Catppuccin
        ├── ui.lua                # Plugins de interfaz (telescope, neo-tree, treesitter, etc.)
        └── lsp.lua               # LSP: mason, lspconfig, autocompletado (nvim-cmp)
```

## Requisitos

- Neovim >= 0.9 (recomendado 0.10+)
- Git
- Un [Nerd Font](https://www.nerdfonts.com/) para que se vean bien los iconos
- `ripgrep` (para la búsqueda de texto de Telescope)
- Node.js / npm (necesario para algunos servidores LSP como `ts_ls`)

## Instalación

1. Respalda tu configuración actual si ya tienes una:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```
2. Copia la carpeta `nvim` de este paquete a `~/.config/nvim`.
3. Abre Neovim:
   ```bash
   nvim
   ```
   `lazy.nvim` se instalará solo y descargará todos los plugins automáticamente la primera vez.
4. Ejecuta `:Mason` para revisar/instalar servidores LSP adicionales si lo necesitas.

## Cambiar el sabor de Catppuccin

En `lua/plugins/colorscheme.lua`, cambia el valor de `flavour`:

- `"latte"` — claro
- `"frappe"`
- `"macchiato"`
- `"mocha"` — oscuro (por defecto)

## Agregar más servidores LSP

Edita la lista `ensure_installed` en `lua/plugins/lsp.lua` (dentro de `mason-lspconfig`) y agrega
la configuración correspondiente en el bloque de `nvim-lspconfig` si el servidor necesita opciones
especiales (como se hizo con `lua_ls`).

## Atajos principales

| Atajo         | Acción                          |
|---------------|----------------------------------|
| `<space>ff`   | Buscar archivos (Telescope)     |
| `<space>fg`   | Buscar texto en el proyecto     |
| `<space>e`    | Abrir/cerrar explorador de archivos |
| `gd`          | Ir a definición (LSP)           |
| `K`           | Ver documentación (LSP)         |
| `<space>ca`   | Acciones de código (LSP)        |
| `<space>rn`   | Renombrar símbolo (LSP)         |
| `<space>f`    | Formatear archivo (LSP)         |
