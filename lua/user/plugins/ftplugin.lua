return {
  "mfussenegger/nvim-jdtls",
  config = function ()
    local config = {
      cmd = {vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls')},
      root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
    }
    vim.api.nvim_create_autocmd("Filetype", {
      pattern = "java", -- autocmd to start jdtls
      callback = function()
        local rootMarkers = {'gradlew', 'mvnw','.git'}
        local status_ok, jdtls = pcall(require("jdtls").start_or_attach(config).find_root(rootMarkers))
        if not status_ok then
          vim.notify("AN ERROR OCCURRED FOR JDTLS")
        end

      end,
    })
  end

}
