-- ~/.config/nvim/lua/plugins/lsp.lua
-- Configuración de LSP (Language Server Protocol)
-- mason.nvim instala los servidores; mason-lspconfig los conecta con lspconfig

return {
  -- Le enseña a lua_ls sobre la API de Neovim (vim.*, plugins, etc.)
  -- Soluciona warnings como "undefined global `vim`" y mejora el autocompletado
  -- al editar tu propia configuración de Neovim.
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Carga los tipos de "luvit" (usado internamente por vim.uv / vim.loop)
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  -- Instalador de LSPs, linters y formatters
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      -- Servidores que se instalarán automáticamente.
      -- Agrega o quita según los lenguajes que uses.
      ensure_installed = {
        "lua_ls",       -- Lua
        "pyright",      -- Python
        "ts_ls",        -- TypeScript / JavaScript
        "html",
        "cssls",
        "jsonls",
        "terraformls",  -- Terraform
        "sqlls",        -- SQL
        "jdtls",        -- Java
        "groovyls",     -- Groovy (Jenkins Pipelines usan sintaxis Groovy)
        "angularls",    -- Angular
        "clangd",       -- C / C++
        "bashls",       -- Bash
      },
      automatic_installation = true,
    },
  },

  -- Configuración del cliente LSP de Neovim
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp", -- capacidades extra para autocompletado
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Atajos de teclado que se activan solo cuando un LSP está adjunto al buffer
      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, noremap = true, silent = true })
        end

        map("n", "gd", vim.lsp.buf.definition, "Ir a la definición")
        map("n", "gD", vim.lsp.buf.declaration, "Ir a la declaración")
        map("n", "gr", vim.lsp.buf.references, "Ver referencias")
        map("n", "gi", vim.lsp.buf.implementation, "Ir a la implementación")
        map("n", "K", vim.lsp.buf.hover, "Mostrar documentación")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Renombrar símbolo")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Acciones de código")
        map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Formatear archivo")
        map("n", "[d", vim.diagnostic.goto_prev, "Diagnóstico anterior")
        map("n", "]d", vim.diagnostic.goto_next, "Diagnóstico siguiente")
        map("n", "<leader>d", vim.diagnostic.open_float, "Mostrar diagnóstico")
      end

      -- Diseño visual de los diagnósticos (errores, warnings...)
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        severity_sort = true,
        float = { border = "rounded" },
      })

      -- Servidores con configuración por defecto (no necesitan opciones extra)
      local default_servers = {
        "pyright",
        "ts_ls",
        "html",
        "cssls",
        "jsonls",
        "terraformls", -- Terraform (.tf, .tfvars)
        "sqlls",       -- SQL
        "clangd",      -- C / C++
        "bashls",      -- Bash / shell scripts
      }
      for _, server in ipairs(default_servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end

      -- lua_ls necesita saber sobre los globals de Neovim (vim.*) y dónde
      -- están las definiciones de su API para no marcar "undefined global vim"
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              -- Le da a lua_ls acceso a los archivos .lua del runtime de Neovim
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      -- Groovy (útil para Jenkinsfile / Jenkins Pipelines, que usan sintaxis Groovy)
      lspconfig.groovyls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "groovy", "Jenkinsfile" },
      })

      -- Angular necesita apuntar a los paquetes de @angular/language-service
      -- instalados en el proyecto (node_modules) para funcionar correctamente.
      lspconfig.angularls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        -- Ajusta estas rutas si tu instalación de Angular está en otro lado
        cmd = { "ngserver", "--stdio", "--tsProbeLocationsBundled", "--ngProbeLocationsBundled" },
      })

      -- Java: configuración básica de jdtls.
      -- NOTA: para proyectos Java grandes (Maven/Gradle multi-módulo) se recomienda
      -- usar el plugin "mfussenegger/nvim-jdtls" en vez de lspconfig directo, ya que
      -- maneja mejor el workspace por proyecto. Esta config básica funciona para
      -- proyectos simples.
      lspconfig.jdtls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        root_dir = require("lspconfig.util").root_pattern(
          "pom.xml", "build.gradle", "build.gradle.kts", ".git"
        ),
      })

      -- Git: no existe un "language server" real para comandos de git.
      -- Si quieres autocompletado/diagnósticos al escribir mensajes de commit
      -- o editar archivos .gitconfig, se puede agregar un servidor específico
      -- para esos filetypes (ej. "gitcommit" con cSpell/efm-langserver). Avísame
      -- si quieres que lo agregue.
    end,
  },

  -- Autocompletado
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "lazydev", group_index = 0 }, -- prioridad más alta para tipos de vim.*
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
