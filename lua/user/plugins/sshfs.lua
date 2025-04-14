return {
 "nosduco/remote-sshfs.nvim",
 dependencies = { "nvim-telescope/telescope.nvim" },
 opts = {
  -- Refer to the configuration section below
  -- or leave empty for defaults
 },
  thing = function ()
    local status_ok, flutter = pcall(require('telescope').load_extension 'remote-sshfs')
    if not status_ok then
      vim.notify("AN ERROR OCCURED WITH SSHFS")
    end
  end,


}
