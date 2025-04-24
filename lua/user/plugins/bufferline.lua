return {
  'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local status_ok, bufferline = pcall(require("bufferline").setup, {
    })

    if not status_ok then
      vim.notify("AN ERROR OCCURED WITH BUFFERLINE")
    end

  end,
}

