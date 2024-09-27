return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-jdtls" -- this needs spesific configureation 
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
        "hdl_checker"
        
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "eslint_d",
        "ts_ls",
        "cssls",
        "hdl_checker"
      },
    })
    lspconfig.hdl_checker.setup({
        on_attach=on_attach,
    })
    
    lspconfig.cssls.setup({
      on_attach = on_attach,
    })
    lspconfig.html.setup({
      on_attach = on_attach,
    })
    lspconfig.pylsp.setup({
      on_attach = on_attach,
    })
    
--    lspconfig.tsserver.setup({ deprecated
  --    on_attach = on_attach,
   -- })
    lspconfig.bashls.setup({
      on_attach = on_attach,
    })
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
    })
    lspconfig.ts_ls.setup({
      on_attach = on_attach,
    })
    -- java spesific config in ftplugin.lua 
  end



}
