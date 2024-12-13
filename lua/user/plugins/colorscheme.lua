return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd([[
  highlight SpellBad   cterm=underline  gui=undercurl"ctermfg=203 guifg=#ff5f5f
  highlight SpellLocal cterm=underline  gui=undercurl "ctermfg=203 guifg=#ff5f5f
  highlight SpellRare  cterm=underline  gui=undercurl"ctermfg=203 guifg=#ff5f5f
  highlight SpellCap  cterm=underline   gui=undercurl"ctermfg=203 guifg=#ff5f5f
]])
    --local theme = colors.theme
    vim.cmd([[colorscheme kanagawa-dragon]])  
  end,
}
