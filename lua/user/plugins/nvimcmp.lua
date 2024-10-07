return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "lspkind.nvim",
    "hrsh7th/cmp-nvim-lsp", -- lsp auto-completion
    "hrsh7th/cmp-buffer", -- buffer auto-completioni
    "hrsh7th/cmp-path", -- path auto-completion
    "hrsh7th/cmp-cmdline", --cmdline auto compleition
  },
  -- config for nvimcmp
  config = function() 
    require("user.plugins.lsp.lspconfig")
  end,

}

