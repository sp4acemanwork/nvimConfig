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
    local status_ok lspcok = pcall(require("user.plugins.lsp.lspc"))
    if not status_ok then
      vim.notify("autocomplete is broken")
    end
  end,

}

