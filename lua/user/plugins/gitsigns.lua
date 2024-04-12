return 
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local status_ok, lualine = pcall(require('gitsigns').setup) 
      if not status_ok then
        vim.error("Error occured loading lualine")
      end
    end

  } 
