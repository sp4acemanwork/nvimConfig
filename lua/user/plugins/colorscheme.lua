return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    --local theme = colors.theme
    vim.cmd([[colorscheme kanagawa-dragon]])  
  end,
}
