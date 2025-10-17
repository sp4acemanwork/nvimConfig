return {
  'stevearc/conform.nvim',
  opts = {
    fomrat_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = {'stylua'},
      markdown = {'prettier'},
    },
  },
  
}
