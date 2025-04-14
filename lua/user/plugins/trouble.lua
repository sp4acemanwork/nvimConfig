return {
  "folke/trouble.nvim",
  config = function ()
    local status_ok, trouble = pcall(require("trouble").setup,{

    })
    if not status_ok then
      vim.notify("we are having trouble")
    end
  end,

}
