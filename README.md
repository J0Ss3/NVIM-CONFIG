# Configuración de Neovim

Config modular basada en `lazy.nvim`, con tema **Ayu** y soporte LSP completo.

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
        ├── colorscheme.lua      # Tema Ayu
        ├── ui.lua                # Plugins de interfaz (telescope, neo-tree, treesitter, etc.)
        └── lsp.lua               # LSP: mason, lspconfig, autocompletado (nvim-cmp)
```

## Requisitos

- Neovim >= 0.9 (recomendado 0.10+)
- Git
- Un [Nerd Font](https://www.nerdfonts.com/) para que se vean bien los iconos
- `ripgrep` (para la búsqueda de texto de Telescope)
- Node.js / npm (necesario para algunos servidores LSP como `ts_ls`)

## Instalación de dependencias por sistema operativo

Neovim necesita ser **>= 0.9** (idealmente 0.10+). Los repositorios de Ubuntu/Debian
suelen traer versiones viejas, así que se recomienda usar el PPA o el AppImage oficial.

### Ubuntu / Debian

```bash
# Neovim (versión reciente vía PPA — solo Ubuntu; en Debian usa el AppImage de abajo)
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install -y neovim

# Herramientas base: git, compilador C (para treesitter/clangd), ripgrep, unzip
sudo apt install -y git build-essential ripgrep unzip curl

# Node.js y npm (necesarios para ts_ls, angularls, groovyls, etc.)
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

# Python y pip (necesarios para pyright)
sudo apt install -y python3 python3-pip

# clangd viene con clang, útil si prefieres instalarlo directo del sistema
sudo apt install -y clangd

# Java (necesario para jdtls) — usa la versión que tu proyecto requiera
sudo apt install -y default-jdk maven

# Un Nerd Font (ejemplo: JetBrainsMono)
mkdir -p ~/.local/share/fonts
curl -fLo /tmp/JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o /tmp/JetBrainsMono.zip -d ~/.local/share/fonts
fc-cache -fv
```

Si `apt` no tiene una versión suficientemente reciente de Neovim en tu Debian
(no existe PPA para Debian), descarga el AppImage oficial:

```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim
```

### Fedora

```bash
# Neovim (los repos de Fedora suelen estar razonablemente actualizados)
sudo dnf install -y neovim

# Herramientas base: git, grupo de compilación (gcc/make/etc.), ripgrep, unzip
sudo dnf groupinstall -y "Development Tools"
sudo dnf install -y git ripgrep unzip curl

# Node.js y npm
sudo dnf install -y nodejs npm

# Python y pip
sudo dnf install -y python3 python3-pip

# clangd (parte del paquete clang-tools-extra)
sudo dnf install -y clang-tools-extra

# Java (necesario para jdtls) y Maven
sudo dnf install -y java-latest-openjdk maven

# Un Nerd Font (ejemplo: JetBrainsMono)
mkdir -p ~/.local/share/fonts
curl -fLo /tmp/JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o /tmp/JetBrainsMono.zip -d ~/.local/share/fonts
fc-cache -fv
```

### Verifica que todo quedó bien instalado

```bash
nvim --version   # >= 0.9 (idealmente 0.10+)
git --version
rg --version     # ripgrep
node --version
npm --version
python3 --version
java --version   # solo si vas a usar jdtls
clangd --version # solo si vas a usar C/C++
```

Después de instalar las dependencias del sistema, sigue con estos pasos para copiar
la config y dejar que `lazy.nvim` descargue los plugins.

## Instalación de la configuración

1. Respalda tu configuración actual si ya tienes una:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```
2. Clona el repositorio directamente en `~/.config/nvim`:
   ```bash
   git clone https://github.com/J0Ss3/NVIM-CONFIG.git ~/.config/nvim
   ```
   (Alternativa sin git: copia la carpeta `nvim` de este paquete a `~/.config/nvim`.)
3. Abre Neovim:
   ```bash
   nvim
   ```
   `lazy.nvim` se instalará solo y descargará todos los plugins automáticamente la primera vez.
4. Ejecuta `:Mason` para revisar/instalar servidores LSP adicionales si lo necesitas.

## Cambiar la variante de Ayu

En `lua/plugins/colorscheme.lua`:

- Pon `mirage = true` en el `setup()` para usar la variante suave "mirage" en vez de "dark".
- Para la variante clara, agrega `vim.o.background = "light"` antes de `vim.cmd.colorscheme("ayu")`, o usa directamente `:colorscheme ayu-light` / `:colorscheme ayu-dark` / `:colorscheme ayu-mirage` desde el comando de Neovim.

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
