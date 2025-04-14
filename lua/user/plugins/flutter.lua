return {
  'nvim-flutter/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim', -- optional for vim.ui.select
  },
  config = true,
  thing = function ()
    local status_ok, flutter = pcall(require("flutter-tools").setup)
    if not status_ok then
      vim.notify("AN ERROR HAS OCCURED WITH FLUTTER PLUGIN")
    end
  end,

}
