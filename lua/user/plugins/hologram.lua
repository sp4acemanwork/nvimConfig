return {
--[[  "edluffy/hologram.nvim",
  config = function ()
    local status_ok, hologram = pcall(require('hologram').setup, {
      auto_display = true
    })
    if not status_ok then
      vim.notify("AN ERROR OCCURED WITH HOLOGRAM")
    end
  end]]--
}
