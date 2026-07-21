-- ~/.config/nvim/lua/plugins/ui.lua
-- Plugins de interfaz y experiencia general (no-LSP)

return {
  -- Iconos (los usan varios plugins)
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- Barra de estado
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        theme = "catppuccin",
        globalstatus = true,
      },
    },
  },

  -- Explorador de archivos
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    opts = {
      filesystem = {
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "open_current",
      },
    },
  },

  -- Buscador difuso (archivos, texto, buffers...)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
  },

  -- Resaltado de sintaxis avanzado
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master", -- IMPORTANTE: fija la rama clásica; "main" es un rewrite
                        -- incompatible que eliminó nvim-treesitter.configs
    build = ":TSUpdate",
    lazy = false, -- carga temprano para evitar problemas con neo-tree
    opts = {
      ensure_installed = {
        "lua", "vim", "vimdoc", "bash", "python", "javascript", "typescript",
        "json", "markdown", "hcl", "terraform", "sql", "java", "groovy",
        "c", "cpp", "gitcommit", "gitignore", "git_config", "git_rebase",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      -- pcall protege el arranque de Neovim si, en la primerísima ejecución,
      -- el plugin todavía no terminó de clonarse cuando se llama config()
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if not ok then
        vim.notify("nvim-treesitter aún no está instalado, corre :Lazy sync", vim.log.levels.WARN)
        return
      end
      configs.setup(opts)
    end,
  },

  -- Indicadores de cambios de Git en el margen
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  -- Auto cerrar y auto etiquetar pares (paréntesis, comillas, tags)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Comentarios rápidos (gcc, gc en visual)
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- Guías de indentación
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- Ayuda visual con los atajos de teclado (which-key)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
