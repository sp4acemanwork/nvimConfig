return {
  "mason-org/mason-lspconfig.nvim",
  opts = {},
  dependencies = {
    { "mason-org/mason.nvim", opts = {} 
    },
    "neovim/nvim-lspconfig",
  },
  config = function ()
    local status_ok, masonlspconfig =  pcall(require("mason-lspconfig").setup, {
      vim.lsp.config('*', {
        capabilities = {
          textDocument = {
            semanticTokens = {
              multilineTokenSupport = true,
            }
          }
        }
      })

    })

    if not status_ok then
      vim.notify("an error has occured in masonlspconfig")
    end
  end

}
