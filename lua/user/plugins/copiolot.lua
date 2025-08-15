return {
--[[  "github/copilot.vim",
  config = function ()
    local status_ok, copilot = pcall(require('gitsigns').setup)

    if not status_ok then
      vim.error("Error something happened with copilot")
    end
    
  end copilot kinda sucks
  ]]
}

