return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "neovim/nvim-lspconfig",
    --"mfussenegger/nvim-jdtls" -- this needs spesific configureation 
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    local lspconfig = require('lspconfig')
    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
          automatic_setup = true,
        },
      },
    })
    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "html",
        "cssls",
        "lua_ls",
        "pylsp",
        "bashls",
        "ts_ls",
        "vhdl_ls",
        "gopls",
      },
    })
    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "eslint_d",
        "ts_ls",
        "cssls",
        "rust_analyzer",
        "gopls",
      },
      automatic_installation = true,

    })

    local servers = {
      pylsp = {
        pylsp = {
          plugins = {
            pycodestyle = {
              ignore = {'E501'},
            }
          }
        }
      }
    }

   local status_ok, jdtls pcall(require("user.plugins.lsp.ftplugin"))
          if not status_ok then
            vim.notify("an error has occured with jdtls fuck you oracle")
          end

    mason_lspconfig.setup_handlers {
      function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {
          on_attach = on_attach,
          settings = servers[server_name],
        }
      end
    }
    -- java spesific config in ftplugin.lua 
  end



}
