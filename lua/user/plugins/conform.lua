-- Corrected version for: lua/user/plugins/conform.lua
return {
  'stevearc/conform.nvim',
  -- Make sure to add this event line to load the plugin correctly
  event = { "BufWritePre" },
  cmd = { "Format" },
  opts = {
    -- This key is now spelled correctly
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      markdown = { 'prettier' },
    },
  },
}
