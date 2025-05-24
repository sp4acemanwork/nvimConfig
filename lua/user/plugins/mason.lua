return {
  "mason-org/mason.nvim",
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-jdtls" -- this needs specific configuration
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    local lspconfig = require('lspconfig')

    -- ====================================================================
    -- PART 1: Simplified `on_attach` function
    -- Since your keybinds are set elsewhere, this can be minimal.
    -- This example just prints a confirmation message.
    -- ====================================================================
    local on_attach = function(client, bufnr)
      -- You can put any buffer-specific settings here that aren't keymaps,
      -- or leave it just like this if you only want confirmation.
      print("LSP attached: " .. client.name .. " to buffer " .. bufnr)

      -- If you truly want NOTHING to happen here, you can even make it:
      -- local on_attach = function(client, bufnr)
      --   -- Intentionally empty if all setup is handled by global LspAttach autocommands
      -- end
    end

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "html",
        "cssls",
        "lua_ls",
        "pylsp",
        "bashls",
        "tsserver", -- Common for TypeScript/JavaScript
        "vhdl_ls",
        "gopls",
      },
      handlers = {
        -- Default handler for most servers
        function(server_name)
          lspconfig[server_name].setup({
            on_attach = on_attach, -- Using the simplified on_attach
          })
        end,

        -- Specific handler for pylsp
        ["pylsp"] = function()
          lspconfig.pylsp.setup({
            on_attach = on_attach, -- Using the simplified on_attach
            settings = {
              pylsp = {
                plugins = {
                  pycodestyle = {
                    ignore = { 'E501' },
                    maxLineLength = 100,
                  },
                }
              }
            }
          })
        end
        -- Add other specific server handlers here if needed
      }
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier",
        "stylua",
        "eslint_d",
      },
      automatic_installation = true,
    })

  end
}
